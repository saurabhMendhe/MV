//
//  MVDownLoadOperationModel.h
//  MVDownLoadManager
//
//  Created by Saurabh Mendhe on 02/11/17.
//  Copyright © 2017 Saurabh Mendhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MVDownLoadOperationModel : NSObject<NSCopying>
@property(nonatomic, strong)NSURL *url;
@property(nonatomic, assign)int requestCount;
@property(nonatomic, strong)NSURLSessionDataTask *dataTask;
@property(nonatomic, strong)NSMutableArray *completionQueues;
@end
