//
//  LoginViewController.m
//  AURA
//
//  Created by MacMiniS on 14-9-25.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "LoginViewController.h"
#import "GoViewController.h"
#import "SignUpViewController.h"
#import "GPSManager.h"
#import "UIImage+Util.h"
#import "CryptoUtil.h"
#import "NSString+Util.h"
#import "NSDate+Util.h"
#import "APIManager.h"
#import "NSData+Util.h"
#import "DataManager.h"
#import "UIImageView+AFNetworking.h"
#import "UIImageView+Util.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btnSkip;
@property (weak, nonatomic) IBOutlet UIButton *btnSignUp;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIImageView *logo2;
@property (weak, nonatomic) IBOutlet UIImageView *logo1;

@property (strong, nonatomic) GoViewController *go;
@property (strong, nonatomic) SignUpViewController *signup;

@end

@implementation LoginViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  //MD5 C0151DA8F2A72E554140A377A7534650
  //SHA1 2ee7d2d34f4f7c01eebac62981336b3e0f27de57
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [GPSManager startUpdatingLocation];
}

- (void)refreshUI {
  self.logo1.image = [DataManager image];
}

#pragma mark - click action
- (IBAction)onClickSkip:(id)sender {
  
}

- (IBAction)onClickSignUp:(id)sender {
  self.signup = [[SignUpViewController alloc] initWithNibName:nil bundle:nil];
  [self.view addSubview:self.signup.view];
  [self performSelector:@selector(popAnimation) withObject:nil afterDelay:0.0];
}

- (IBAction)onClickLogin:(id)sender {
  self.go = [[GoViewController alloc] initWithNibName:nil bundle:nil];
  [self.view addSubview:self.go.view];
  [self performSelector:@selector(popAnimation) withObject:nil afterDelay:0.0];
}

- (void)popAnimation {
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:0.3];
  [UIView setAnimationDelay:0.1];
  self.logo1.frame = CGRectMake(109, 60, 102, 31);
  [UIView commitAnimations];
}

@end
