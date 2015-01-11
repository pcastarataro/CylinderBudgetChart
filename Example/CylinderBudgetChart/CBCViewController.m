//
//  CBCViewController.m
//  CylinderBudgetChart
//
//  Created by pablo castarataro on 01/11/2015.
//  Copyright (c) 2014 pablo castarataro. All rights reserved.
//

#import "CBCViewController.h"

@interface CBCViewController () {
    CGFloat value;
}

@property (strong, nonatomic) IBOutlet CBCCylinderBudgetChartView *chart;

@end

@implementation CBCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    value = 50;
    self.chart.delegate = self;
    self.chart.dataSource = self;
    [self.chart reloadData];
}

#pragma mark DataSource
-(CGFloat)totalValueForChart:(CBCCylinderBudgetChartView*) chart {
    return 255;
}

-(CGFloat)fillValueForChart:(CBCCylinderBudgetChartView*) chart {
    return value;
}

-(NSString*) totalTextWithValue:(CGFloat)value1 ForChart:(CBCCylinderBudgetChartView*) chart {
    return [NSString stringWithFormat:@"Total: %.0f", value1];
}

#pragma mark Delegate
-(UIColor*)backgroundColorForChart:(CBCCylinderBudgetChartView*) chart {
    return [UIColor whiteColor];
}

-(UIColor*)fillColorForChart:(CBCCylinderBudgetChartView*) chart {
    CGFloat red = value;
    CGFloat green = 255 - value;
    
    red = red / 255.0;
    green = green / 255.0;
    
    return [UIColor colorWithRed:red green:green blue:0 alpha:1.0];
}

-(UIFont*)fillValueFontForChart:(CBCCylinderBudgetChartView*) chart {
    return [UIFont boldSystemFontOfSize:14];
}

-(UIFont*)totalValueFontForChart:(CBCCylinderBudgetChartView*) chart {
    return [UIFont boldSystemFontOfSize:14];
}

-(UIColor*)fillValueFontColorForChart:(CBCCylinderBudgetChartView*) chart {
    CGFloat color = value;
    if(value < 128)
        color = 0;
    if(value >=128)
        color = 255;
    color /= 255;
    
    return [UIColor colorWithRed: color green: color blue:color alpha:1];
}

-(UIColor*)totalValueFontColorForChart:(CBCCylinderBudgetChartView*) chart {
    return [UIColor darkGrayColor];
}

-(CGFloat)totalValueHeightForChart:(CBCCylinderBudgetChartView*)chart {
    return 20;
}

-(CGFloat)fillValueHeightForChart:(CBCCylinderBudgetChartView*)chart {
    return 20;
}

-(BOOL)shouldShowTotalValueForChart:(CBCCylinderBudgetChartView*)chart {
    return YES;
}

-(BOOL)shouldShowFillValueForChart:(CBCCylinderBudgetChartView*)chart {
    if(value == 0)
        return NO;
    return YES;
}

-(UIColor*)gradientColorForChart:(CBCCylinderBudgetChartView*) chart {
    return [UIColor brownColor];
}

-(CGFloat)gradientAlpha:(CBCCylinderBudgetChartView*) chart {
    return 0.3;
}
#pragma mark Actions
-(IBAction)onValueChanged:(UISlider*)sender {
    value = sender.value;
    [self.chart reloadData];
}

@end
