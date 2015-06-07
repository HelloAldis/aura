//
//  CameraViewController.m
//  AURA
//
//  Created by MacMiniS on 14-10-10.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

@import Photos;

#import "CameraControlView.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "MainToolbar.h"
#import "ViewControllerContainer.h"
#import "ActivitySearchingCell.h"
#import "UIImage+Util.h"
#import "APIManager.h"
#import "UIView+Util.h"
#import "DataManager.h"
#import "ActivityCell.h"

@interface CameraControlView ()

@property (weak, nonatomic) IBOutlet UIButton *btnFlashMode;
@property (weak, nonatomic) IBOutlet UIImageView *lastImage;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) BOOL isSearchDone;
@property (nonatomic, strong) NSObject *o;

@end

@implementation CameraControlView

+ (CameraControlView *)cameraControlView {
  return [[[NSBundle mainBundle] loadNibNamed:@"CameraControlView" owner:nil options:nil] lastObject];
}

+ (BOOL)startCameraControllerFromViewController: (UIViewController*) controller {
  if (TARGET_IPHONE_SIMULATOR) {
    CameraControlView *cameraControlView = [CameraControlView cameraControlView];
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
      imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.view.frame = CGRectMake(0, 0, 320, 320);
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    imagePickerController.allowsEditing = NO;
    imagePickerController.delegate = cameraControlView;
    
    cameraControlView.o = cameraControlView;
    
    [controller presentViewController:imagePickerController animated:YES completion:NULL];
    cameraControlView.imagePickerController = imagePickerController;
    
    return YES;
  } else {
    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO) ||
        ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] == NO))
      return NO;
    
    CameraControlView *cameraControlView = [CameraControlView cameraControlView];
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.view.frame = CGRectMake(0, 0, 320, 320);
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    imagePickerController.allowsEditing = NO;
    imagePickerController.delegate = cameraControlView;
    CGAffineTransform translate = CGAffineTransformMakeTranslation(0.0, 64);
    imagePickerController.cameraViewTransform = translate;
    imagePickerController.showsCameraControls = NO;
    imagePickerController.cameraOverlayView = cameraControlView;
    
    [controller presentViewController:imagePickerController animated:YES completion:NULL];
    cameraControlView.imagePickerController = imagePickerController;
    
    return YES;
  }

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  UIImage *originalImage = (UIImage *) [info objectForKey:
                                        UIImagePickerControllerOriginalImage];
  
  if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
    // Save the new image (original or edited) to the Camera Roll
    originalImage = [originalImage getSquareImage];
    UIImageWriteToSavedPhotosAlbum (originalImage, nil, nil , nil);
  } else {
    originalImage = [originalImage getCenterSquareImage];
    self.lastImage.image = originalImage;
  }
  
  [self.imagePickerController.presentingViewController dismissViewControllerAnimated:NO completion:NULL];
  [ViewControllerContainer showFilter:originalImage];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
}

- (IBAction)onClickCancel:(id)sender {
  [self.imagePickerController.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
  [MainToolbar showMainToolbar];
}

- (IBAction)OnClickSwith:(id)sender {
  if (self.imagePickerController.cameraDevice == UIImagePickerControllerCameraDeviceRear) {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.imagePickerController.view cache:YES];
    [UIView setAnimationDuration:0.5];
    self.imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    [UIView commitAnimations];
  } else {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.imagePickerController.view cache:YES];
    [UIView setAnimationDuration:0.5];
    self.imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    [UIView commitAnimations];
  }
}

- (IBAction)onClickFlash:(id)sender {
  if (self.imagePickerController.cameraFlashMode == UIImagePickerControllerCameraFlashModeAuto) {
    self.imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
    [self.btnFlashMode setImage:[UIImage imageNamed:@"闪光灯不加关闭"] forState:UIControlStateNormal];
  } else if (self.imagePickerController.cameraFlashMode == UIImagePickerControllerCameraFlashModeOn) {
    self.imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
    [self.btnFlashMode setImage:[UIImage imageNamed:@"闪光灯icon"] forState:UIControlStateNormal];
  } else if (self.imagePickerController.cameraFlashMode == UIImagePickerControllerCameraFlashModeOff) {
    self.imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
    [self.btnFlashMode setImage:[UIImage imageNamed:@"闪光灯A"] forState:UIControlStateNormal];
  }
}

- (IBAction)onClickTake:(id)sender {
  [self.imagePickerController takePicture];
}

- (IBAction)onClickImage:(id)sender {
  self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
}

- (void)getLastestImageFromPhoto {
  PHFetchOptions *options = [[PHFetchOptions alloc] init];
  options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
  options.predicate = [NSPredicate predicateWithFormat:@"mediaType == %d", PHAssetMediaTypeImage];
  PHFetchResult *result = [PHAsset fetchAssetsWithOptions:options];
  PHAsset *asset = [result firstObject];

  PHImageRequestOptions *opt = [[PHImageRequestOptions alloc] init];
  
  // Download from cloud if necessary
  opt.networkAccessAllowed = NO;
  opt.synchronous = YES;
  
  [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(50, 50)
                                            contentMode:PHImageContentModeAspectFit
                                                options:opt
                                          resultHandler:^(UIImage *result, NSDictionary *info) {
    if (result) {
      self.lastImage.image = result;
      [self.lastImage setCornerRadius:4];
    }
  }];
  
}

- (void)awakeFromNib {
  [self.tableView registerNib:[UINib nibWithNibName:@"ActivityCell" bundle:nil] forCellReuseIdentifier:@"ActivityCell"];
  [self.tableView registerNib:[UINib nibWithNibName:@"ActivitySearchingCell" bundle:nil] forCellReuseIdentifier:@"ActivitySearchingCell"];
  self.isSearchDone = NO;
  
//  if (!self.lastImage.image) {
    [self getLastestImageFromPhoto];
//  }
  
  [self performSelector:@selector(doRecommend) withObject:nil afterDelay:1];
}

- (void)doRecommend {
  RecommendAlbumRequest *request = [[RecommendAlbumRequest alloc] init];
  [APIManager recommendAlbum:request success:^{
    self.isSearchDone = YES;
    [self.tableView reloadData];
  } failure:^{
    self.isSearchDone = YES;
    [self.tableView reloadData];
  }];
}

#pragma mark - table view delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (self.isSearchDone) {
    return [DataManager recommendAlbumArray].count >= 1 ? 1 : 0;
  } else {
    return 1;
  }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (self.isSearchDone) {
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityCell"];
    [cell initWithPhoto:[[DataManager recommendAlbumArray] firstObject]];
    return cell;
  } else {
    ActivitySearchingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivitySearchingCell" forIndexPath:indexPath];
    return cell;
  }
}

@end
