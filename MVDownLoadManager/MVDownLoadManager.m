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

+(void)startUrlRequest:(NSURL *)url useCache:(BOOL)useCache WithCompletionBlock: (NetworkCompletionBlock)completionBlock{
    [MVDownLoadOperation startUrlRequest:url useCache:useCache WithCompletionBlock:completionBlock];
}

+(void)cancelRequest:(NSURL *)url forCompletionBlock: (NetworkCompletionBlock)completionBlock{
    [MVDownLoadOperation cancelRequest:url forCompletionBlock:completionBlock];
}

@end
