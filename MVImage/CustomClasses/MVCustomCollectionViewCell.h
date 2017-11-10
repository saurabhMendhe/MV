//
//  MVCustomCollectionViewCell.h
//  MVImage
//
//  Created by Saurabh Mendhe on 02/11/17.
//  Copyright © 2017 Saurabh Mendhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MVDownLoadManager.h"
@interface MVCustomCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *overview;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *ratings;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *releaseDate;
-(void)setImageWithUrl:(NSURL *)url;
@end
