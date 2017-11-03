//
//  MVMovieModal.m
//  MVImage
//
//  Created by Saurabh Mendhe on 03/11/17.
//  Copyright © 2017 Saurabh Mendhe. All rights reserved.
//

#import "MVMovieModal.h"

@implementation MVMovieModal
@synthesize imageurl;
@synthesize overview;
@synthesize ratings;
@synthesize title;
@synthesize releaseDate;
- (id)copyWithZone:(NSZone *)zone
{
    id copy = [[[self class] alloc] init];
    if (copy) {
        [copy setImageurl:[self.imageurl copyWithZone:zone]];
        [copy setRatings:self.ratings];
        [copy setOverview:[self.overview copyWithZone:zone]];
        [copy setTitle:[self.title copyWithZone:zone]];
        [copy setReleaseDate:[self.releaseDate copyWithZone:zone]];
    }
    return copy;
}
@end
