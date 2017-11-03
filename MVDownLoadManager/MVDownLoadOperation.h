//
//  MVDownloadOperation.h
//  MVDownLoadManager
//
//  Created by Saurabh Mendhe on 02/11/17.
//  Copyright © 2017 Saurabh Mendhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MVDownLoadManager.h"
@interface MVDownLoadOperation : NSObject<NSURLSessionDataDelegate,MVDownLoadManagerDelegate>

+(void)cancelRequest:(NSURL *)url delegate:(id<MVDownLoadManagerDelegate>)delegate;
+(void)startUrlRequest:(NSURL *)url useCache:(BOOL)useCache delegate:(id<MVDownLoadManagerDelegate>)delegate;
@end
