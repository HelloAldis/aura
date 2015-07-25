//
//  ErrorMessageManager.m
//  AURA
//
//  Created by KindAzrael on 14/10/19.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import "ErrorMessageManager.h"
#import "APIDefines.h"

@implementation ErrorMessageManager

+ (NSString *)handleMessage:(NSString *)resultCode {
  switch ([resultCode integerValue]) {
    case CODE_OK:
      return nil;
    case CODE_BADPARAMS:
      return @"输入错误";
    case CODE_ACCOUNT_ACCOUNTNOTMATCH:
      return @"用户名错误";
    case CODE_ACCOUNT_PASSWORDERROR:
      return @"密码错误";
    case CODE_ACCOUNT_DBERROR:
      return @"数据库错误";
    case CODE_ACCOUNT_EXIST:
      return @"用户名已存在";
    case CODE_ACCOUNT_NICKNAME_EXIST:
      return @"昵称已存在";
    case CODE_SESSION_EXPIRED:
      return @"session过期";
    default:
      return nil;
      break;
  }
}

@end
