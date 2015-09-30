//
//  VZSliderFilter.h
//  VZSliderFilterDemo
//
//  Created by mini4s215 on 9/28/15.
//  Copyright © 2015 mini4s215. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VZSliderFilter : UIControl

@property (nonatomic) UIColor *sliderColor;
@property(nonatomic) NSInteger selectedIndex;


-(id)initWithFrame:(CGRect)frame andTitlesArray:(NSArray *)titlesArray;

-(void) setTitlesColor:(UIColor *)color;
-(void) setTitlesFont:(UIFont *)font;
-(void) setHandlerColor:(UIColor *)color;

@end
