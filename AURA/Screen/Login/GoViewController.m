//
//  SignUpViewController.m
//  AURA
//
//  Created by MacMiniS on 14-9-25.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "GoViewController.h"
#import "AppDelegate.h"
#import "ViewControllerContainer.h"
#import "APIManager.h"
#import "NSString+Util.h"
#import "DataManager.h"

@interface GoViewController ()

@property (weak, nonatomic) IBOutlet UITextField *fldPhone;
@property (weak, nonatomic) IBOutlet UITextField *fldPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIView *frame;

@end

@implementation GoViewController

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.fldPhone becomeFirstResponder];
  [self showFrame];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(validateInput) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  
  [[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:nil];
}

- (void)showFrame {
  CABasicAnimation *anmation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
  anmation.duration = 0.3;
  anmation.fromValue = @568.0;
  anmation.toValue = @0.0;
  [self.frame.layer addAnimation:anmation forKey:nil];
}

- (IBAction)onBackgroundTap:(id)sender {
  [self.view removeFromSuperview];
}

#pragma mark - text field delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  if (textField == self.fldPhone) {
    [self.fldPassword becomeFirstResponder];
  } else if (textField == self.fldPassword) {
    [self doLogin];
  }
  
  return NO;
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//  textField.text = [textField.text stringByReplacingCharactersInRange:range withString:string];
//  
//  [self validateInput];
//  return NO;
//}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
  textField.text = @"";
  [self validateInput];
  return YES;
}

#pragma mark - user event
- (IBAction)onClickLogin:(id)sender {
  [self doLogin];
}

- (void)doLogin {
  LoginRequest *request = [[LoginRequest alloc] init];
  [request setType:kLoginTypeEmail];
  [request setAccount:self.fldPhone.text];
  [request setPassword:self.fldPassword.text];

#ifdef ADEBUG
  [self loginSuccess];
#else
  [APIManager login:request success:^{
    [DataManager setPassword:self.fldPassword.text];
    [DataManager setUsername:self.fldPhone.text];
    [self loginSuccess];
  } failure:^{}];
#endif
  
}

- (void)loginSuccess{
  [ViewControllerContainer showWPViewController];
}

- (void)validateInput {
  if ([self validatePassword] && [self validateUser]) {
    self.btnLogin.enabled = YES;
    [self.btnLogin setImage:[UIImage imageNamed:@"对勾"] forState:UIControlStateNormal];
  } else {
    self.btnLogin.enabled = NO;
    [self.btnLogin setImage:[UIImage imageNamed:@"灰色对勾"] forState:UIControlStateNormal];
  }
}

- (BOOL)validateUser {
  return ![self.fldPhone.text isEmpty];
}

- (BOOL)validatePassword {
  return ![self.fldPassword.text isEmpty];
}

@end
