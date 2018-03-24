//
//  TTLinkerHandler.m
//  TTFeedback
//
//  Created by Ming on 2018/3/24.
//  Copyright © 2018年 Sara. All rights reserved.
//

#import "TTLinkerHandler.h"
#import "TTFeedbackViewController.h"

@implementation TTLinkerHandler
+(id)handleDealWithHref:(NSURL *)url{
    NSString *action=[[url.host lowercaseString] description];
    if ([action isEqualToString:@"feedback"]) {
        TTFeedbackViewController *feedback=[[TTFeedbackViewController alloc]init];
        return feedback;
    }
    return nil;
}

@end
