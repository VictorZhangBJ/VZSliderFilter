//
//  VZSliderKnob.m
//  VZSliderFilterDemo
//
//  Created by mini4s215 on 9/28/15.
//  Copyright © 2015 mini4s215. All rights reserved.
//

#import "VZSliderKnob.h"

@implementation VZSliderKnob

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setHandlerColor:[UIColor colorWithRed:230/255.f green:230/255.f blue:230/255.f alpha:1]];
    }
    return self;
}

-(void)setHandlerColor:(UIColor *)handlerColor
{
    self.handlerColor = handlerColor;
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    CGColorRef shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f].CGColor;
    CGContextRef contenxt = UIGraphicsGetCurrentContext();
    
    //Draw Main Circle
    CGContextSaveGState(contenxt);
    
}
@end
