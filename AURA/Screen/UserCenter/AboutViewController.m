//
//  AboutViewController.m
//  AURA
//
//  Created by KindAzrael on 15/4/25.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self initNav];
}

- (void)initNav {
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(onClickBack)];
  self.title = @"关于AURA";
}

- (void)onClickBack {
  [self.navigationController popViewControllerAnimated:YES];
}

@end
