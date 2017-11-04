//
//  MVDownLoadManagerTests.m
//  MVDownLoadManagerTests
//
//  Created by Saurabh Mendhe on 01/11/17.
//  Copyright © 2017 Saurabh Mendhe. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MVDownLoadManager.h"



@interface TestClass : NSObject<MVDownLoadManagerDelegate>{
    
}
@end

@implementation TestClass
-(void)downloadManagerDidComplete:(NSData *)respondeData{
    
}
-(void)downloadManagerDidFail:(NSError *)error{
    
}
@end
@interface MVDownLoadManagerTests : XCTestCase<MVDownLoadManagerDelegate>

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
    TestClass *classTest = [[TestClass alloc] init];
    NSString *url =  @"http://api.themoviedb.org/3/search/movie?api_key=2696829a81b1b5827d515ff121700838&query=Bond&page=1";
    [MVDownLoadManager startUrlRequest:[NSURL URLWithString:url] useCache:YES delegate:classTest];
    [MVDownLoadManager startUrlRequest:[NSURL URLWithString:url] useCache:NO delegate:classTest];
    [MVDownLoadManager startUrlRequest:[NSURL URLWithString:url] useCache:NO delegate:classTest];
    [MVDownLoadManager cancelRequest:[NSURL URLWithString:url] delegate:classTest];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
