//
//  BaseTableView.m
//  AURA
//
//  Created by MacMiniS on 15-4-16.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import "BaseTableView.h"

@interface BaseTableView ()

@property (nonatomic, assign) SEL fun;
@property (nonatomic, weak) NSObject *obj;

@end

@implementation BaseTableView

- (void)setFun:(SEL)fun withObject:(NSObject *)obj {
  self.fun = fun;
  self.obj = obj;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesBegan:touches withEvent:event];
  [self endEditing:YES];
  
  if (self.fun != nil && self.obj != nil) {
    [self.obj performSelectorOnMainThread:self.fun withObject:nil waitUntilDone:NO];
  }
}

@end
