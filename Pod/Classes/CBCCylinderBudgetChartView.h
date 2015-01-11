//
//  CylinderBudgetChartView.h
//  CylinderBudgetChartDemo
//
//  Created by Pablo Castarataro on 1/11/15.
//  Copyright (c) 2015 Pablo Castarataro. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CBCCylinderBudgetChartView;

@protocol CBCCylinderBudgetChartViewDataSource <NSObject>

-(CGFloat)totalValueForChart:(CBCCylinderBudgetChartView*) chart;
-(CGFloat)fillValueForChart:(CBCCylinderBudgetChartView*) chart;

@optional
-(NSString*) totalTextWithValue:(CGFloat)value ForChart:(CBCCylinderBudgetChartView*) chart;
@optional
-(NSString*) fillTextWithValue:(CGFloat)value ForChart:(CBCCylinderBudgetChartView*) chart;

@end

@protocol CBCCylinderBudgetChartViewDelegate <NSObject>

@optional
-(UIColor*)backgroundColorForChart:(CBCCylinderBudgetChartView*) chart;
@optional
-(UIColor*)fillColorForChart:(CBCCylinderBudgetChartView*) chart;
@optional
-(UIFont*)fillValueFontForChart:(CBCCylinderBudgetChartView*) chart;
@optional
-(UIFont*)totalValueFontForChart:(CBCCylinderBudgetChartView*) chart;
@optional
-(UIColor*)fillValueFontColorForChart:(CBCCylinderBudgetChartView*) chart;
@optional
-(UIColor*)totalValueFontColorForChart:(CBCCylinderBudgetChartView*) chart;
@optional
-(CGFloat)totalValueHeightForChart:(CBCCylinderBudgetChartView*)chart;
@optional
-(CGFloat)fillValueHeightForChart:(CBCCylinderBudgetChartView*)chart;
@optional
-(BOOL)shouldShowTotalValueForChart:(CBCCylinderBudgetChartView*)chart;
@optional
-(BOOL)shouldShowFillValueForChart:(CBCCylinderBudgetChartView*)chart;

@end

@interface CBCCylinderBudgetChartView : UIView

@property(nonatomic, retain) id<CBCCylinderBudgetChartViewDataSource> dataSource;
@property(nonatomic, retain) id<CBCCylinderBudgetChartViewDelegate> delegate;

-(void)reloadData;

@end
