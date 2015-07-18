//
//  UserSettingViewController.m
//  AURA
//
//  Created by MacMiniS on 14-10-13.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "UserSettingViewController.h"
#import "NSDate+Util.h"
#import "DataManager.h"
#import "UIImageView+Util.h"
#import "APIManager.h"
#import "SVProgressHUD.h"
#import "NSString+Util.h"
#import "UIImage+Util.h"
#import "ViewControllerContainer.h"
#import "UIView+Util.h"

@interface UserSettingViewController ()

@property (weak, nonatomic) IBOutlet UITextField *fldNickName;
@property (weak, nonatomic) IBOutlet UITextField *fldSignature;
@property (weak, nonatomic) IBOutlet UILabel *fldLoginName;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *lblPassword;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;

@end

@implementation UserSettingViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self initNav];
  self.scrollView.contentSize = CGSizeMake(320, 600);
  [self.userImageView setCornerRadius:35];
  [self.userImageView setBorder:2 andColor:[[UIColor whiteColor] CGColor]];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  
  self.fldNickName.text = [DataManager userInfo].nickname;
  self.fldSignature.text = [DataManager userInfo].sign;
  self.lblPassword.text = [DataManager password];
  self.fldLoginName.text = [DataManager username];
  
  if ([DataManager latestUploadedImageId] != nil) {
    [self.userImageView setUserImageWithSha1:[DataManager latestUploadedImageId]];
  } else {
    [self.userImageView setUserImageWithSha1:[DataManager userInfo].thumbnail];
  }
}

- (void)initNav {
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(onClickBack)];
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
  self.title = @"帐户设置";
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesEnded:touches withEvent:event];
  [self.view endEditing:YES];
}

- (void)onClickBack {
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)save {
  [self.view endEditing:YES];
  
  if ([self.fldNickName.text isEmpty]) {
    [SVProgressHUD showErrorWithStatus:@"昵称不能为空"];
    return;
  }
  
  if (![self.fldSignature.text isEqualToString:[DataManager userInfo].sign]) {
    UpdateSignRequest *req1 = [[UpdateSignRequest alloc] init];
    [req1 setsign:self.fldSignature.text];
    [APIManager updateSign:req1 success:^{} failure:^{}];
  }
  
  if (![self.fldNickName.text isEqualToString:[DataManager userInfo].nickname]) {
    UpdateNicknameRequest *req2 = [[UpdateNicknameRequest alloc] init];
    [req2 setnickname:self.fldNickName.text];
    [APIManager updateNickname:req2 success:^{
      [SVProgressHUD showSuccessWithStatus:@"更新成功"];
    } failure:^{
      [SVProgressHUD showErrorWithStatus:@"昵称重复"];
    }];
  }

}

#pragma mark - text field delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  if (textField == self.fldNickName) {
    [self.fldSignature becomeFirstResponder];
  } else if (textField == self.fldSignature) {
    [self.view endEditing:YES];
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
  
}

- (IBAction)onClickImage:(id)sender {
  UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
  imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
  
  // Hides the controls for moving & scaling pictures, or for
  // trimming movies. To instead show the controls, use YES.
  imagePickerController.allowsEditing = NO;
  imagePickerController.delegate = self;
  
  [self presentViewController:imagePickerController animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  UIImage *originalImage = (UIImage *) [info objectForKey:
                                        UIImagePickerControllerOriginalImage];
  
  originalImage = [originalImage getCenterSquareImage];
  
  [self dismissViewControllerAnimated:NO completion:NULL];
  [ViewControllerContainer showEditUserImage:originalImage];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
