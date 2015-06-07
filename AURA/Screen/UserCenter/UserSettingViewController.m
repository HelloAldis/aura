//
//  UserSettingViewController.m
//  AURA
//
//  Created by MacMiniS on 14-10-13.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "UserSettingViewController.h"
#import "NSDate+Util.h"

@interface UserSettingViewController ()

@property (weak, nonatomic) IBOutlet UITextField *fldNickName;
@property (weak, nonatomic) IBOutlet UITextField *fldSignature;
@property (weak, nonatomic) IBOutlet UILabel *fldLoginName;
@property (weak, nonatomic) IBOutlet UITextField *fldPassword;
@property (weak, nonatomic) IBOutlet UILabel *fldBirthday;
@property (weak, nonatomic) IBOutlet UITextField *fldCity;
@property (weak, nonatomic) IBOutlet UIButton *btnMale;
@property (weak, nonatomic) IBOutlet UIButton *btnFemale;
@property (weak, nonatomic) IBOutlet UIButton *btnScrect;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIView *datePickerBackground;

@end

@implementation UserSettingViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self initNav];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  //Get user birthday
  NSString *birthday = @"1990.01.01";
  self.datePicker.date = [NSDate dateFromString:birthday];
  self.fldBirthday.text = birthday;
}

- (void)initNav {
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(onClickBack)];
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
  self.title = @"帐户设置";
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [self.view endEditing:YES];
  [self saveBirthday];
  [self hideDatePicker];
}

- (void)onClickBack {
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)save {
  [self.view endEditing:YES];
}

#pragma mark - text field delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  if (textField == self.fldNickName) {
    [self.fldSignature becomeFirstResponder];
  } else if (textField == self.fldSignature) {
    [self.fldPassword becomeFirstResponder];
  } else if(textField == self.fldPassword) {
    [self.fldCity becomeFirstResponder];
  } else if(textField == self.fldCity) {
    [self save];
  }
  
  return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  if (textField == self.fldPassword) {
    [UIView animateWithDuration:0.3 animations:^{
      self.view.frame = CGRectMake(0, 64-50, 320, 504);
    }];
  } else if (textField == self.fldCity) {
    [UIView animateWithDuration:0.3 animations:^{
      self.view.frame = CGRectMake(0, 64-180, 320, 504);
    }];
  }
  
  [self saveBirthday];
  [self hideDatePicker];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
  [UIView animateWithDuration:0.3 animations:^{
    self.view.frame = CGRectMake(0, 64, 320, 504);
  }];
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
  
}

- (void)showDatePicker {
  [UIView animateWithDuration:0.3 animations:^{
    self.datePickerBackground.frame = CGRectMake(0, 295, 320, 162);
  } completion:^(BOOL finished){
    self.datePickerBackground.frame = CGRectMake(0, 295, 320, 162);
  }];
}

- (void)hideDatePicker {
  [UIView animateWithDuration:0.3 animations:^{
    self.datePickerBackground.frame = CGRectMake(0, 504, 320, 162);
  } completion:^(BOOL finished) {
    self.datePickerBackground.frame = CGRectMake(0, 504, 320, 162);
  }];
}

- (IBAction)onTapBirthday:(id)sender {
  [self.view endEditing:YES];
  [self showDatePicker];
}

- (IBAction)onClickMale:(id)sender {
  [self.btnMale setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
  [self.btnFemale setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
  [self.btnScrect setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
}

- (IBAction)onClickFemale:(id)sender {
  [self.btnFemale setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
  [self.btnMale setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
  [self.btnScrect setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
}

- (IBAction)onClickScrect:(id)sender {
  [self.btnScrect setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
  [self.btnMale setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
  [self.btnFemale setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
}

- (void)saveBirthday {
  self.fldBirthday.text = [NSDate stringFromDate:self.datePicker.date];
}

@end
