//
//  ViewController.m
//  VZSliderFilterDemo
//
//  Created by mini4s215 on 9/28/15.
//  Copyright © 2015 mini4s215. All rights reserved.
//

#import "ViewController.h"
#import "VZSliderFilter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    // Do any additional setup after loading the view, typically from a nib.
    
    VZSliderFilter *slider = [[VZSliderFilter alloc] initWithFrame:CGRectMake(20, 100, 300, 70) andTitlesArray:@[@"-3",@"-2",@"-1",@"0",@"1",@"2",@"3"]];
    [slider addTarget:self action:@selector(slideValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
}

-(void)slideValueChanged:(VZSliderFilter *)slide
{
    NSLog(@"选中 index = %ld",slide.selectedIndex);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
