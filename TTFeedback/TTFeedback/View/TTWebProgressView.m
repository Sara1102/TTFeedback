//
//  TTWebProgressView.m
//  TTFeedback
//
//  Created by Ming on 2018/3/24.
//  Copyright © 2018年 Sara. All rights reserved.
//

#import "TTWebProgressView.h"
static CGFloat stopWidth;

@interface TTWebProgressView()
@property (nonatomic, strong) UIView *progress;
@property (nonatomic, strong) NSLayoutConstraint *pWidth;
@property (nonatomic, assign) BOOL finished;

@end

@implementation TTWebProgressView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(UIView *)progress{
    if (!_progress) {
        _progress=[[UIView alloc]init];
         [self.progress setBackgroundColor:[UIColor colorWithRed:199.0/255.0 green:74.0/255.0 blue:47.0/255.0 alpha:1.0]];
        [self addSubview:_progress];
        _progress.translatesAutoresizingMaskIntoConstraints=NO;
        NSLayoutConstraint *left=[NSLayoutConstraint constraintWithItem:_progress attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:750 constant:0];
        self.pWidth=[NSLayoutConstraint constraintWithItem:_progress attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:750 constant:100];
        NSLayoutConstraint *top=[NSLayoutConstraint constraintWithItem:_progress attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:750 constant:0];
        NSLayoutConstraint *heigth=[NSLayoutConstraint constraintWithItem:_progress attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:750 constant:5];
        stopWidth=[UIScreen mainScreen].bounds.size.width-70;
        [self addConstraint:left];
        [self addConstraint:self.pWidth];
        [self addConstraint:top];
        [self addConstraint:heigth];
        
    }
    return _progress;
}
-(void)startLoading{
    self.finished=NO;
    [self.progress setHidden:NO];
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        if (self.finished) {
            self.pWidth.constant=[UIScreen mainScreen].bounds.size.width;
             [self.progress setHidden:YES];
        }else{
            self.pWidth.constant=[UIScreen mainScreen].bounds.size.width-70;
        }
        [self layoutIfNeeded];
     }];
}
-(void)stopLoading{
    self.finished=YES;
    if (self.pWidth.constant==stopWidth) {
        self.pWidth.constant=[UIScreen mainScreen].bounds.size.width;
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
        dispatch_after(time, dispatch_get_main_queue(), ^{
            [self hiddenPro];
        });
    }
}
-(void)hiddenPro{
    [self.progress setHidden:YES];
    
}

@end
