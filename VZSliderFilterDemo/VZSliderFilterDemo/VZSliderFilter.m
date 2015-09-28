//
//  VZSliderFilter.m
//  VZSliderFilterDemo
//
//  Created by mini4s215 on 9/28/15.
//  Copyright © 2015 mini4s215. All rights reserved.
//

#import "VZSliderFilter.h"

@interface VZSliderFilter()

@property (nonatomic, strong) NSArray *titlesArray;


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

-(void)setUp
{
    
}
@end
