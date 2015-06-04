//
//  CryptoUtil.h
//  AURA
//
//  Created by KindAzrael on 14/10/30.
//  Copyright (c) 2014年 AURA. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define AccessID @"44CF9590006BF252F707"
//#define AccessKeySecret @"OtxrzxIsfpFjA7SwPzILwy8Bw21TLhquhboDYROV"
#define AccessID @"8qyE85QH1EBRiV23"
#define AccessKeySecret @"8mkGjw4OkFbKAyWLLdntlSZZ4Q7nEU"
#define GET_METHOD @"GET"
#define PUT_METHOD @"PUT"

@interface CryptoUtil : NSObject

+ (NSString *)sha1:(NSData *)data;
+ (NSString *)signatureMethod:(NSString *)method withDate:(NSString *)date withName:(NSString *)name;

@end
