//
//  MVDownLoadManager.h
//  MVDownLoadManager
//
//  Created by Saurabh Mendhe on 02/11/17.
//  Copyright © 2017 Saurabh Mendhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MVDownLoadManagerDelegate
@optional
-(void)downloadManagerDidComplete:(NSData *)respondeData;
-(void)downloadManagerDidFail:(NSError *)error;
@end
@interface MVDownLoadManager : NSObject
{
    id <MVDownLoadManagerDelegate> __weak delegate;
}
@property (nonatomic, weak) id <MVDownLoadManagerDelegate> delegate;

+(void)startUrlRequest:(NSURL *)url useCache:(BOOL)useCache delegate:(id<MVDownLoadManagerDelegate>)delegate;
+(void)cancelRequest:(NSURL *)url delegate:(id<MVDownLoadManagerDelegate>)delegate;
+ (int) delegateCountForUrl:(NSURL *)url;
+ (BOOL) isDownloadingItemWithURL:(NSURL*)url;
@end
