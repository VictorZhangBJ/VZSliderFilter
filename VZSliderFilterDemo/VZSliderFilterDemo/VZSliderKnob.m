//
//  VZSliderKnob.m
//  VZSliderFilterDemo
//
//  Created by mini4s215 on 9/28/15.
//  Copyright © 2015 mini4s215. All rights reserved.
//

#import "VZSliderKnob.h"

@implementation VZSliderKnob
{
    CGFloat _width;
    CGFloat _strokeLineWidth;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setHandlerColor:[UIColor whiteColor]];
    }
    return self;
}

-(void)setHandlerColor:(UIColor *)handlerColor
{
    _handlerColor = handlerColor;
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    _width = rect.size.width;
    _strokeLineWidth = 10;
    //CGColorRef shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f].CGColor;
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //Draw Main Circle
    CGContextSaveGState(context);
    //CGContextSetShadowWithColor(context, CGSizeMake(0, 7), 10.f, shadowColor);
    
    CGContextSetStrokeColorWithColor(context, self.handlerColor.CGColor);
    CGContextSetLineWidth(context,_strokeLineWidth);
    
    CGFloat originX = _strokeLineWidth/2.0;
    CGFloat widthX = _width - _strokeLineWidth;
    
    CGContextStrokeEllipseInRect(context, CGRectMake(originX, originX, widthX, widthX));
    
    //UIBezierPath *mainCirclePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(17.5, 17.5) radius:17.5 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    //[mainCirclePath stroke];

    CGContextRestoreGState(context);
    
    //Draw Outer outline
    CGContextSaveGState(context);
    
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:0.5 alpha:0.6].CGColor);
    CGContextSetLineWidth(context, 1);
    CGContextStrokeEllipseInRect(context, CGRectMake(rect.origin.x + 1.5f, rect.origin.y+1.2f, _width - 1.5*2.0, _width - 1.5*2.0));
    CGContextRestoreGState(context);
    
//    //Drwa Inner Outline
//    CGContextSaveGState(context);
//    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:0.5 alpha:0.6].CGColor);
//    CGContextSetLineWidth(context, 1);
//    CGContextStrokeEllipseInRect(context, CGRectMake(rect.origin.x + 12.5, rect.origin.y+12, 10, 10));
//    CGContextRestoreGState(context);
//    
    //Draw Gradienet color
    CGFloat colors[8] = {0,0,0,0,
        0,0,0,0.6};
    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, colors, NULL, 2);
    
    CGContextSaveGState(context);
    CGContextAddEllipseInRect(context, CGRectMake(rect.origin.x + 1.2, rect.origin.y+0.8, _width - 1.2*2, _width - 1.2*2));
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, CGPointZero, CGPointMake(0, rect.size.height), 0);
    CGContextRestoreGState(context);
    
}
@end
