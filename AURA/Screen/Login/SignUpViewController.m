//
//  SignUpViewController.m
//  AURA
//
//  Created by MacMiniS on 14-9-25.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "SignUpViewController.h"
#import "APIManager.h"
#import "NSString+Util.h"
#import "ViewControllerContainer.h"

@interface SignUpViewController ()

@property (weak, nonatomic) IBOutlet UITextField *fldPhone;
@property (weak, nonatomic) IBOutlet UITextField *fldPassword;
@property (weak, nonatomic) IBOutlet UITextField *fldUsername;
@property (weak, nonatomic) IBOutlet UIButton *btnArrow;
@property (weak, nonatomic) IBOutlet UIView *frame;

@end

@implementation SignUpViewController

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.fldPhone becomeFirstResponder];
  [self showFrame];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)showFrame {
  CABasicAnimation *anmation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
  anmation.duration = 0.3;
  anmation.fromValue = @568.0;
  anmation.toValue = @0.0;
  [self.frame.layer addAnimation:anmation forKey:nil];
}

- (IBAction)onClickSign:(id)sender {
  [self doSign];
}

- (IBAction)onTouchBackground:(id)sender {
  [self.view removeFromSuperview];
}

- (void)doSign {
  RegistRequest *request = [[RegistRequest alloc] init];
  [request setEmail:self.fldPhone.text];
  [request setPassword:self.fldPassword.text];
  [request setNickName:self.fldUsername.text];
  
  [APIManager emailRegist:request success:^{
    [self onTouchBackground:nil];
    LoginRequest *request = [[LoginRequest alloc] init];
    [request setType:kLoginTypeEmail];
    [request setAccount:self.fldPhone.text];
    [request setPassword:self.fldPassword.text];
    
#ifdef ADEBUG
    [self loginSuccess];
#else
    [APIManager login:request success:^{
      [ViewControllerContainer showWPViewController];
    } failure:^{}];
#endif
    
  } failure:^{}];
}

#pragma mark - text field delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  if (textField == self.fldPhone) {
    [self.fldPassword becomeFirstResponder];
  } else if (textField == self.fldPassword) {
    [self.fldUsername becomeFirstResponder];
  } else if (textField == self.fldUsername) {
    [self doSign];
  }
  
  return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  textField.text = [textField.text stringByReplacingCharactersInRange:range withString:string];
  
  [self validateInput];
  return NO;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
  textField.text = @"";
  [self validateInput];
  return YES;
}

- (void)validateInput {
  BOOL isNickNameOK = [self validateNickName];
  
  if ([self validatePassword] && [self validateUser] && isNickNameOK) {
    self.btnArrow.enabled = YES;
    [self.btnArrow setImage:[UIImage imageNamed:@"对勾"] forState:UIControlStateNormal];
  } else {
    self.btnArrow.enabled = NO;
    [self.btnArrow setImage:[UIImage imageNamed:@"灰色对勾"] forState:UIControlStateNormal];
  }
}

- (BOOL)validateNickName {
  BOOL isEmpty = [self.fldUsername.text isEmpty];
  if (!isEmpty) {
    CheckNickNameRequest *request = [[CheckNickNameRequest alloc] init];
    [request setNickName:self.fldUsername.text];
    [APIManager checkNickName:request success:^{
      [self.fldUsername setTextColor:[UIColor blackColor]];
    } failure:^{
      [self.fldUsername setTextColor:[UIColor redColor]];
      [self wrongNickNameAnimation];
    }];
  }

  return !isEmpty;
}

- (BOOL)validateUser {
  return ![self.fldPhone.text isEmpty];
}

- (BOOL)validatePassword {
  return ![self.fldPassword.text isEmpty];
}

- (void)wrongNickNameAnimation {
  CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
  animation.values = @[@0.0f, @10.0f, @-10.0f, @10.0f, @0.0f];
  animation.keyTimes = @[@0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1];
  [self.fldUsername.layer addAnimation:animation forKey:nil];
}

@end
