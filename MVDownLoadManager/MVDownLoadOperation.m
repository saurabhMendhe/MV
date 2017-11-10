//
//  MVDownloadOperation.m
//  MVDownLoadManager
//
//  Created by Saurabh Mendhe on 02/11/17.
//  Copyright © 2017 Saurabh Mendhe. All rights reserved.
//

#import "MVDownLoadOperation.h"
#import "MVDownLoadOperationModel.h"
@interface MVDownLoadOperation(){
    NSMutableDictionary *operationDic;
    NSMutableData *receivedData;
}
@end
@implementation MVDownLoadOperation

+ (MVDownLoadOperation*) instance
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
        operationDic = [[NSMutableDictionary alloc] init];
        NSUInteger cashSize = 250 * 1024 * 1024; // 500MB
        NSUInteger cashDiskSize = 250 * 1024 * 1024;// 500MB
        NSURLCache *imageCache = [[NSURLCache alloc] initWithMemoryCapacity:cashSize diskCapacity:cashDiskSize diskPath:@"someCachePath"];
        [NSURLCache setSharedURLCache:imageCache];
    }
    return self;
}

+(void)cancelRequest:(NSURL *)url forCompletionBlock: (NetworkCompletionBlock)completionBlock
{
    if ([[self instance]->operationDic objectForKey:url]) {
        MVDownLoadOperationModel *operationModel = [[self instance]->operationDic objectForKey:url];
        if (operationModel.requestCount>1) {
            operationModel.requestCount--;
            [operationModel.completionQueues removeObject:completionBlock];
        }else if (operationModel.requestCount == 1){
            if (operationModel.dataTask != nil && (operationModel.dataTask.state != NSURLSessionTaskStateSuspended)) {
                [operationModel.dataTask suspend];
            }else{
                // Not running URL
            }
        }
        return;
    }
}

- (NSURLSession *)prepareSessionForRequest
{
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    [sessionConfiguration setHTTPAdditionalHeaders:@{@"Content-Type": @"application/json", @"Accept": @"application/json"}];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    return session;
}
+(void)startUrlRequest:(NSURL *)url useCache:(BOOL)useCache WithCompletionBlock: (void (^)(NSData *respondeData, NSError *error))completionBlock{
    if (![[self instance]->operationDic objectForKey:url]){
        NSURLSession *session = [[self instance] prepareSessionForRequest];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"GET"];
        __block MVDownLoadOperation* operationObj = [self instance];
        NSCachedURLResponse *cachedResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:request];
        if (cachedResponse.data && useCache) {
            dispatch_async(dispatch_get_main_queue(), ^(void){
                completionBlock(cachedResponse.data,nil);
            });
        } else {
            NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                            if (error)
                                                                completionBlock(nil,error);
                                                            else {
                                                                MVDownLoadOperationModel *operationModel = [operationObj->operationDic objectForKey:response.URL];
                                                                for (int i = 0 ; i < operationModel.completionQueues.count; i++) {
                                                                    operationModel.requestCount--;
                                                                     void(^cBlock)(NSData *data, NSError *error) = [operationModel.completionQueues objectAtIndex:i];
                                                                    if (error) {
                                                                        dispatch_async(dispatch_get_main_queue(), ^(void){
                                                                            cBlock(nil,error);
                                                                        });
                                                                    }else{
                                                                        if ([data length]) {
                                                                            dispatch_async(dispatch_get_main_queue(), ^(void){
                                                                                cBlock(data,nil);
                                                                            });
                                                                        }else{
                                                                            dispatch_async(dispatch_get_main_queue(), ^(void){
                                                                                cBlock(nil,error);
                                                                            });
                                                                        }
                                                                    }
                                                                }
                                                                if (operationModel.requestCount==0) {
                                                                    [operationObj->operationDic removeObjectForKey:response.URL];
                                                                }
                                                            }
                                                        }];
            MVDownLoadOperationModel *operationModel = [[MVDownLoadOperationModel alloc] init];
            operationModel.url = dataTask.originalRequest.URL;
            operationModel.requestCount = 1;
            operationModel.dataTask = dataTask;
            if (completionBlock!=nil) {
                operationModel.completionQueues = [[NSMutableArray alloc]initWithObjects:completionBlock, nil];
                [[self instance]->operationDic setObject:operationModel forKey:dataTask.originalRequest.URL];
            }
            [dataTask resume];
        }
    }else{
        MVDownLoadOperationModel *operationModel = [[self instance]->operationDic objectForKey:url];
        operationModel.requestCount = operationModel.requestCount + 1;
        NSMutableArray *completionQueues = operationModel.completionQueues;
        [completionQueues addObject:completionBlock];
        operationModel.completionQueues = completionQueues;
    }
}

#pragma mark - NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    receivedData=nil;
    receivedData = [[NSMutableData alloc] init];
    [receivedData setLength:0];
    completionHandler(NSURLSessionResponseAllow);
}

-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
   didReceiveData:(NSData *)data {
    [receivedData appendData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error {
    MVDownLoadOperationModel *operationModel = [operationDic objectForKey:task.originalRequest.URL];
    for (int i = 0 ; i < operationModel.completionQueues.count; i++) {
        operationModel.requestCount--;
        void(^cBlock)(NSData *data, NSError *error) = [operationModel.completionQueues objectAtIndex:i];
        if (error) {
            cBlock(nil,error);
        }else{
            if ([receivedData length]) {
                cBlock(receivedData,error);
            }else{
                cBlock(nil,error);
            }
        }
    }
    if (operationModel.requestCount==0) {
        [operationDic removeObjectForKey:task.originalRequest.URL];
    }
}
@end

