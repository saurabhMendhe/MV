//
//  MVDownLoadManager.m
//  MVDownLoadManager
//
//  Created by Saurabh Mendhe on 02/11/17.
//  Copyright © 2017 Saurabh Mendhe. All rights reserved.
//

#import "MVDownLoadManager.h"
#import "MVDownLoadOperation.h"
@interface MVDownLoadManager(){
    
}
@end
@implementation MVDownLoadManager
@synthesize delegate;


+ (MVDownLoadManager*) instance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

+(void)startUrlRequest:(NSURL *)url useCache:(BOOL)useCache delegate:(id<MVDownLoadManagerDelegate>)delegate{
    [MVDownLoadOperation startUrlRequest:url useCache:YES delegate:delegate];
}

+(void)cancelRequest:(NSURL *)url delegate:(id<MVDownLoadManagerDelegate>)delegate{
    [MVDownLoadOperation cancelRequest:url delegate:delegate];
}
+ (int) delegateCountForUrl:(NSURL *)url{
    return 0;
}
+ (BOOL) isDownloadingItemWithURL:(NSURL*)url{
    return YES;
}


@end
