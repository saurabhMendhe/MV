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
    [MVDownLoadManager startUrlRequest:url useCache:YES WithCompletionBlock:^(NSData *respondeData, NSError *error) {
        if (error == nil) {
            self.imageView.contentMode = UIViewContentModeScaleAspectFit;
            self.imageView.image = [UIImage imageWithData:respondeData];
        }else{
            
        }
    }];
}

-(void)resetCell{

}
@end
