//
//  MVDownLoadManagerTests.m
//  MVDownLoadManagerTests
//
//  Created by Saurabh Mendhe on 01/11/17.
//  Copyright © 2017 Saurabh Mendhe. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface MVDownLoadManagerTests : XCTestCase

@end

@implementation MVDownLoadManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    //[self downloadManagerDidComplete:[use objectForKey:key]];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSUserDefaults *use = [NSUserDefaults standardUserDefaults];
    NSString *key = [NSString stringWithFormat:@"data1"];
    NSData *data = [use objectForKey:key];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
