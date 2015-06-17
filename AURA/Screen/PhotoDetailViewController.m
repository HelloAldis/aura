//
//  PhotoDetailViewController.m
//  AURA
//
//  Created by KindAzrael on 15/6/7.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import "CommentTableViewCell.h"
#import "PhotoTableViewCell.h"
#import "APIManager.h"
#import "DataManager.h"
#import "MainToolbar.h"

@interface PhotoDetailViewController ()

@property(strong, nonatomic) UUInputFunctionView *inputFunctionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PhotoDetailViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self initView];
  [self initNav];
  [self.tableView registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"CommentTableViewCell"];
  [self.tableView registerNib:[UINib nibWithNibName:@"PhotoTableViewCell" bundle:nil] forCellReuseIdentifier:@"PhotoTableViewCell"];
  [self.tableView registerNib:[UINib nibWithNibName:@"TagTableViewCell" bundle:nil] forCellReuseIdentifier:@"TagTableViewCell"];
  
  [self handleRefresh];
}

- (void)handleRefresh {
  QueryCommentRequest *request = [[QueryCommentRequest alloc] init];
  [request setPhotoid:self.photo.photoid];
  [request setSize:10000];
  
  [APIManager queryComment:request success:^{
    [self.tableView reloadData];
  } failure:^{
  }];
}

- (void)initView {
  self.inputFunctionView = [[UUInputFunctionView alloc]initWithSuperVC:self];
  self.inputFunctionView.delegate = self;
  [self.view addSubview:self.inputFunctionView];
}

- (void)initNav {
  self.title = @"照片详情";
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStyleDone target:self action:@selector(onBack)];
}

- (void)onBack {
  [self.navigationController popViewControllerAnimated:YES];
  [MainToolbar showMainToolbar];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  
  //add notification
  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillShowNotification object:nil];
  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillHideNotification object:nil];
  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tableViewScrollToBottom) name:UIKeyboardDidShowNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)keyboardChange:(NSNotification *)notification
{
  NSDictionary *userInfo = [notification userInfo];
  NSTimeInterval animationDuration;
  UIViewAnimationCurve animationCurve;
  CGRect keyboardEndFrame;
  
  [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
  [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
  [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
  
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:animationDuration];
  [UIView setAnimationCurve:animationCurve];
  
  //adjust ChatTableView's height
  if (notification.name == UIKeyboardWillShowNotification) {
    self.bottom.constant = keyboardEndFrame.size.height+40;
  }else{
    self.bottom.constant = 40;
  }
  
  [self.view layoutIfNeeded];
  
  //adjust UUInputFunctionView's originPoint
  CGRect newFrame = self.inputFunctionView.frame;
  newFrame.origin.y = keyboardEndFrame.origin.y - newFrame.size.height - 64;
  self.inputFunctionView.frame = newFrame;
  
  [UIView commitAnimations];
  
}

//tableView Scroll to bottom
- (void)tableViewScrollToBottom {
  NSInteger row = 0;
  row += [DataManager comments].count;
  
  [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

//res_showResDetail('683364','酶反应器分类及其操作参数','1','ppt','6172')
#pragma - mark UUInputFunctionView delegate
- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendMessage:(NSString *)message {
  [self.view endEditing:YES];
  funcView.TextViewInput.text = @"";
  funcView.btnSendMessage.enabled = NO;
  funcView.btnSendMessage.alpha = 0.5;
  
  AddCommentRequest *request = [[AddCommentRequest alloc] init];
  [request setCommment:message];
  [request setPhotoid:self.photo.photoid];
  [APIManager addComment:request success:^{
    [self handleRefresh];
    [self tableViewScrollToBottom];
  } failure:^{}];
}

#pragma - mark
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  NSInteger row = 1;
  row += [DataManager comments].count;
  
  return row;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath; {
  if (indexPath.row == 0) {
    return 483;
  } else {
    // init with comments
    return 60;
  }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = nil;
  if (indexPath.row == 0) {
    cell = [tableView dequeueReusableCellWithIdentifier:@"PhotoTableViewCell" forIndexPath:indexPath];
    PhotoTableViewCell *pCell = (PhotoTableViewCell *)cell;
    [pCell initWithPhoto:self.photo];
    pCell.supperController = self;
  } else {
    cell = [tableView dequeueReusableCellWithIdentifier:@"CommentTableViewCell" forIndexPath:indexPath];
    CommentTableViewCell *cCell = (CommentTableViewCell *)cell;
    [cCell initWithComment:[[DataManager comments] objectAtIndex:indexPath.row - 1]];
  }
  
  return cell;
}


@end
