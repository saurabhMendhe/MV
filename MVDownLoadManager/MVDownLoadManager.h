//
//  MVDownLoadManager.h
//  MVDownLoadManager
//
//  Created by Saurabh Mendhe on 02/11/17.
//  Copyright © 2017 Saurabh Mendhe. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface MVDownLoadManager : NSObject
typedef void(^NetworkCompletionBlock)(NSData *respondeData, NSError *error);
+(void)startUrlRequest:(NSURL *)url useCache:(BOOL)useCache WithCompletionBlock: (NetworkCompletionBlock)completionBlock;
+(void)cancelRequest:(NSURL *)url forCompletionBlock: (NetworkCompletionBlock)completionBlock;
@end
