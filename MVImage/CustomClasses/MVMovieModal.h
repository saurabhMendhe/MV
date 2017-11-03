//
//  MVMovieModal.h
//  MVImage
//
//  Created by Saurabh Mendhe on 03/11/17.
//  Copyright © 2017 Saurabh Mendhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MVMovieModal : NSObject
@property(nonatomic, strong)NSURL *imageurl;
@property(nonatomic, assign)float ratings;
@property(nonatomic, strong)NSString *overview;
@property(nonatomic, strong)NSString *title;
@property(nonatomic, strong)NSString *releaseDate;
@end
