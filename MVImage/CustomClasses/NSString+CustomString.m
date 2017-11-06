//
//  NSString+CustomString.m
//  MVImage
//
//  Created by Saurabh Mendhe on 06/11/17.
//  Copyright © 2017 Saurabh Mendhe. All rights reserved.
//

#import "NSString+CustomString.h"

@implementation NSString (CustomString)

+(NSString *)trimString:(NSString *)string{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"  +" options:NSRegularExpressionCaseInsensitive error:&error];
    string = [regex stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, [string length]) withTemplate:@" "];
    return string;
}
@end
