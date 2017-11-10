//
//  MVDownLoadOperationModel.m
//  MVDownLoadManager
//
//  Created by Saurabh Mendhe on 02/11/17.
//  Copyright © 2017 Saurabh Mendhe. All rights reserved.
//

#import "MVDownLoadOperationModel.h"

@implementation MVDownLoadOperationModel
@synthesize url;
@synthesize requestCount;
@synthesize dataTask;


- (id)copyWithZone:(NSZone *)zone
{
    id copy = [[[self class] alloc] init];
    if (copy) {
        [copy setUrl:[self.url copyWithZone:zone]];
        [copy setRequestCount:self.requestCount];
        [copy setDataTask:[self.dataTask copyWithZone:zone]];
        [copy setCompletionQueues:[self.completionQueues copyWithZone:zone]];
    }
    return copy;
}
@end
