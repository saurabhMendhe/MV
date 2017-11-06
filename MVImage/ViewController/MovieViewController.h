//
//  MovieViewControllerViewController.h
//  MVImage
//
//  Created by Saurabh Mendhe on 01/11/17.
//  Copyright © 2017 Saurabh Mendhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MVDownLoadManager.h"
@protocol MovieVCDelegate
-(void)saveSearchItems:(NSString *)movieName;
@end
@interface MovieViewController : UIViewController<MVDownLoadManagerDelegate>
{
    id <MovieVCDelegate> __weak delegate;
}
@property (nonatomic, weak) id <MovieVCDelegate> delegate;
-(void)setMovieName:(NSString *)_movieName;
@end

