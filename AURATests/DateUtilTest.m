//
//  DateUtilTest.m
//  AURA
//
//  Created by MacMiniS on 15-4-20.
//  Copyright (c) 2015年 AURA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSDate+Util.h"

@interface DateUtilTest : XCTestCase

@end

@implementation DateUtilTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetTimeStringFrom {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
  NSString *str = [NSDate getTimeStringFrom:@"2015-04-18 11:10:00"];
  NSLog(@"%@", str);
  
}


@end
