//
//  VZSliderFilter.m
//  VZSliderFilterDemo
//
//  Created by mini4s215 on 9/28/15.
//  Copyright © 2015 mini4s215. All rights reserved.
//

#import "VZSliderFilter.h"
#import "VZSliderKnob.h"

@interface VZSliderFilter()

@property (nonatomic, strong) NSArray *titlesArray;
@property (nonatomic, strong) VZSliderKnob *handler;

@property (nonatomic) CGFloat leftOffset;
@property (nonatomic) CGFloat rightOffset;
@property (nonatomic) CGFloat titleSelectedDistance;
@property (nonatomic) CGFloat titleFadeAlpha;
@property (nonatomic) UIFont *titleFont;
@property (nonatomic) UIColor *titleShaowColor;
@property (nonatomic) UIColor *titleColor;
@property (nonatomic) CGFloat oneSlotSize;
@property (nonatomic) CGPoint diffPoint;
@property (nonatomic) CGFloat progressHeight;
@end

@implementation VZSliderFilter

-(id)initWithFrame:(CGRect)frame andTitlesArray:(NSArray *)titlesArray
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titlesArray = [NSArray arrayWithArray:titlesArray];
        [self setUp];
    }
    return self;
}

-(void)configueSlider
{
    self.backgroundColor = [UIColor orangeColor];
    self.leftOffset = 25.0;
    self.rightOffset = 25.0;
    self.titleSelectedDistance = 5.0;
    self.titleFadeAlpha = 0.5;
    self.titleFont = [UIFont systemFontOfSize:14];
    //self.titleShaowColor = [UIColor lightGrayColor];
    self.titleColor = [UIColor whiteColor];
    self.sliderColor = [UIColor whiteColor];
    self.progressHeight = 5.0;
}

-(void)setUp
{
    [self configueSlider];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemSelected:)];
    [self addGestureRecognizer:gesture];
    
    _handler = [VZSliderKnob buttonWithType:UIButtonTypeCustom];
    [_handler setFrame:CGRectMake(_leftOffset, 10, 20, 20)];
    [_handler setAdjustsImageWhenDisabled:NO];
    [_handler setCenter:CGPointMake(_handler.center.x -(_handler.frame.size.width/2.0), self.frame.size.height/2.0 + _progressHeight/2.0)];
    [_handler addTarget:self action:@selector(touchDown: withEvent:) forControlEvents:UIControlEventTouchDown];
    [_handler addTarget:self action:@selector(touchUp:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    [_handler addTarget:self action:@selector(touchMove: withEvent:) forControlEvents:UIControlEventTouchDragInside | UIControlEventTouchDragOutside];
    
    [self addSubview:_handler];
    
    _oneSlotSize = 1.0*(self.frame.size.width - _leftOffset - _rightOffset)/(CGFloat)(_titlesArray.count -1);
    for (NSInteger i=0; i< _titlesArray.count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _oneSlotSize, 25)];
        label.text = _titlesArray[i];
        label.font = _titleFont;
        label.shadowColor = _titleShaowColor;
        label.textColor = _titleColor;
        label.lineBreakMode = NSLineBreakByTruncatingMiddle;
        label.adjustsFontSizeToFitWidth = YES;
        label.textAlignment = NSTextAlignmentCenter;
        label.shadowOffset = CGSizeMake(0, 1);
        label.backgroundColor = [UIColor clearColor];
        label.tag = i + 50;
        if (i) {
            [label setAlpha:_titleFadeAlpha];
        }
        [label setCenter:[self getCenterPointForIndex:i]];
        [self addSubview:label];
    }
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorRef shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9].CGColor;
    
    //Fill main path
//    CGContextSetFillColorWithColor(context, self.sliderColor.CGColor);
//    CGContextFillRect(context, CGRectMake(_leftOffset, rect.size.height/2.0, rect.size.width - _leftOffset - _rightOffset, _progressHeight));
    CGRect progressRect = CGRectMake(_leftOffset, rect.size.height/2.0, rect.size.width-_leftOffset-_rightOffset, _progressHeight);
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, self.sliderColor.CGColor);
    UIBezierPath *roundPath = [UIBezierPath bezierPathWithRoundedRect:progressRect byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerTopRight
                                                          cornerRadii:CGSizeMake(_progressHeight/2.0, _progressHeight/2.0)];
    [roundPath fill];
    
    CGContextRestoreGState(context);
    
//    //Draw Black top shadow
//    CGContextSetShadowWithColor(context, CGSizeMake(0, 1.0f), 2.0f, shadowColor);
//    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6].CGColor);
//    CGContextSetLineWidth(context, 0.5);
//    CGContextBeginPath(context);
//    CGContextMoveToPoint(context, _leftOffset+2, rect.size.height/2.0);
//    CGContextAddLineToPoint(context, rect.size.width - _rightOffset, rect.size.height/2.0);
//    CGContextStrokePath(context);
//    
//    CGContextRestoreGState(context);
//    
//    //Draw White Bottom shadow
//    CGContextSaveGState(context);
//    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:1 green:1 blue:1 alpha:1].CGColor);
//    CGContextSetLineWidth(context, 0.4);
//    CGContextBeginPath(context);
//    CGContextMoveToPoint(context, _leftOffset, rect.size.height/2.0 + _progressHeight);
//    CGContextAddLineToPoint(context, rect.size.width - _rightOffset, rect.size.height/2.0 + _progressHeight);
//    CGContextStrokePath(context);
//    
//    CGContextRestoreGState(context);
//    
//    //Draw Round rect
//    

    for (NSInteger i = 0; i < _titlesArray.count; i++) {
        CGPoint centerPoint = [self getCenterPointForIndex:i];
        //draw selection circles
        CGFloat circleRadius = 6.0;
        CGContextSaveGState(context);
        CGContextSetFillColorWithColor(context, self.sliderColor.CGColor);
        CGContextFillEllipseInRect(context, CGRectMake(centerPoint.x - circleRadius , _handler.center.y - circleRadius, 2*circleRadius, 2*circleRadius));
        CGContextRestoreGState(context);
        
    }
    
}

-(void)animateTitleToIndex:(NSInteger)index
{
    for (NSInteger i = 0; i < _titlesArray.count; i++) {
        UILabel *label = (UILabel *)[self viewWithTag:i+50];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationBeginsFromCurrentState:YES];
        if (i == index) {
            label.center = CGPointMake(label.center.x, self.frame.size.height - 55 - _titleSelectedDistance);
            [label setAlpha:1];
        }else{
            label.center = CGPointMake(label.center.x, self.frame.size.height - 55);
            [label setAlpha:_titleFadeAlpha];
        }
        [UIView commitAnimations];
    }
}

-(void)animateHandlerToIndex:(NSInteger)index
{
    CGPoint toPoint = [self getCenterPointForIndex:index];
    toPoint = CGPointMake(toPoint.x - (_handler.frame.size.width/2.0), _handler.frame.origin.y);
    toPoint = [self fixFinalPoint:toPoint];
    
    [UIView beginAnimations:nil context:nil];
    _handler.frame = CGRectMake(toPoint.x, toPoint.y, _handler.frame.size.width, _handler.frame.size.height);
    [UIView commitAnimations];
    
}



-(CGPoint)fixFinalPoint:(CGPoint)point
{
    if (point.x + (_handler.frame.size.width/2.0) < _leftOffset) {
        point.x = _leftOffset - (_handler.frame.size.width/2.0);
    }else if (point.x + (_handler.frame.size.width/2.0) > self.frame.size.width - _rightOffset){
        point.x = self.frame.size.width - _rightOffset - (_handler.frame.size.width/2.0);
    }
    return point;
}
-(CGPoint)getCenterPointForIndex:(NSInteger)index
{
    CGFloat pointX = _oneSlotSize * index + _leftOffset;
    CGFloat pointY = index==0? self.frame.size.height - 55 - _titleSelectedDistance : self.frame.size.height - 55;
    return CGPointMake(pointX, pointY);
}

-(void)touchDown:(UIButton *)btn withEvent:(UIEvent *)event
{
    CGPoint currentPoint = [[[event allTouches] anyObject] locationInView:self];
    _diffPoint = CGPointMake(currentPoint.x - btn.frame.origin.x, currentPoint.y - btn.frame.origin.y);
    [self sendActionsForControlEvents:UIControlEventTouchDown];
}

-(void)touchUp:(UIButton *)btn
{
    _selectedIndex = [self getSelectedTitleInPoint:btn.center];
    [self animateHandlerToIndex:_selectedIndex];
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

-(void)touchMove:(UIButton *)btn withEvent:(UIEvent *)event
{
    CGPoint currPoint = [[[event allTouches] anyObject] locationInView:self];
    
    CGPoint toPoint = CGPointMake(currPoint.x - _diffPoint.x, _handler.frame.origin.y);
    toPoint = [self fixFinalPoint:toPoint];
    _handler.frame = CGRectMake(toPoint.x, toPoint.y, _handler.frame.size.width, _handler.frame.size.height);
    
    NSInteger selected = [self getSelectedTitleInPoint:btn.center];
    [self animateTitleToIndex:selected];
    [self sendActionsForControlEvents:UIControlEventTouchDragInside];
}


-(void)itemSelected:(UITapGestureRecognizer *)gesture
{
    self.selectedIndex = [self getSelectedTitleInPoint:[gesture locationInView:self]];
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    
}

-(NSInteger)getSelectedTitleInPoint:(CGPoint)point
{
    NSInteger index = round((point.x - _leftOffset)/_oneSlotSize);
    return index;
}
-(void)setSelectedIndex:(NSInteger)index
{
    _selectedIndex = index;
    [self animateHandlerToIndex:_selectedIndex];
    [self animateTitleToIndex:_selectedIndex];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}
-(void) setTitlesColor:(UIColor *)color
{
    for(NSInteger i=0;i < _titlesArray.count; i++){
        UILabel *label = (UILabel *)[self viewWithTag:i+50];
        label.textColor = color;
    }
}
-(void) setTitlesFont:(UIFont *)font
{
    for(NSInteger i=0;i < _titlesArray.count; i++){
        UILabel *label = (UILabel *)[self viewWithTag:i+50];
        label.font = font;
    }
}
-(void) setHandlerColor:(UIColor *)color
{
    [_handler setHandlerColor:color];
}
@end
