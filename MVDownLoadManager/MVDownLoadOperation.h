//
//  MVDownloadOperation.h
//  MVDownLoadManager
//
//  Created by Saurabh Mendhe on 02/11/17.
//  Copyright © 2017 Saurabh Mendhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MVDownLoadManager.h"

typedef void(^NetworkCompletionBlock)(NSData *respondeData, NSError *error);
@interface MVDownLoadOperation : NSObject<NSURLSessionDataDelegate>

+(void)cancelRequest:(NSURL *)url forCompletionBlock: (NetworkCompletionBlock)completionBlock;
+(void)startUrlRequest:(NSURL *)url useCache:(BOOL)useCache WithCompletionBlock: (void (^)(NSData *respondeData, NSError *error))completionBlock;
@end
