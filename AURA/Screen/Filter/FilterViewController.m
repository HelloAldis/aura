//
//  FilterViewController.m
//  AURA
//
//  Created by MacMiniS on 14-10-27.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "FilterViewController.h"
#import "ViewControllerContainer.h"
#import "FilterOptionCollectionViewCell.h"

@interface FilterViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation FilterViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self initNav];
  [self initStatusBar];
  [self.collectionView registerNib:[UINib nibWithNibName:@"FilterOptionCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"FilterOptionCollectionViewCell"];
  self.scrollView.contentSize = CGSizeMake(320, 320);
  self.scrollView.maximumZoomScale = 3.0;
  self.scrollView.minimumZoomScale = 1.0;
  
  DDLogDebug(@"photo size %@", NSStringFromCGSize(self.orignalImage.size));
}

- (void)initStatusBar {
  [[UIApplication sharedApplication] setStatusBarHidden:NO];
  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
  [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewWillAppear:(BOOL)animated {
  self.imageView.image = self.orignalImage;
}

- (void)initNav {
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(onClickBack)];
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(onClickOk)];
  self.title = @"滤镜";
}

- (void)onClickBack {
  [self.navigationController popViewControllerAnimated:NO];
  [ViewControllerContainer showCameraViewController];
}

- (void)onClickOk {
  [ViewControllerContainer showShare:self.orignalImage];
}

#pragma mark - collection view
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return 4;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  FilterOptionCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"FilterOptionCollectionViewCell" forIndexPath:indexPath];
  return cell;
}

#pragma mark - scroll view delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
  return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
  [self.view setNeedsLayout];
  [self.view layoutIfNeeded];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
  
}

@end
