//
//  MVCustomCollectionViewCell.m
//  MVImage
//
//  Created by Saurabh Mendhe on 02/11/17.
//  Copyright © 2017 Saurabh Mendhe. All rights reserved.
//

#import "MVCustomCollectionViewCell.h"

@implementation MVCustomCollectionViewCell
-(void)setImageWithUrl:(NSURL *)url{
    [MVDownLoadManager startUrlRequest:url useCache:YES delegate:self];
}
-(void)downloadManagerDidComplete:(NSData *)respondeData{
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.image = [UIImage imageWithData:respondeData];
}
-(void)downloadManagerDidFail:(NSError *)error{
    
}

-(void)resetCell{

}
@end
