//
//  CylinderBudgetChartView.m
//  CylinderBudgetChartDemo
//
//  Created by Pablo Castarataro on 1/11/15.
//  Copyright (c) 2015 Pablo Castarataro. All rights reserved.
//

#import "CBCCylinderBudgetChartView.h"

@interface CBCCylinderBudgetChartView() {
    UIView* gradientEffectView;
    UIView* backgroundView;
    UIView* fillView;
    UILabel* totalLabel;
    UILabel* fillLabel;
    
    UIColor* chartBackgroundColor;
    UIColor* chartFillColor;
    UIColor* fillLabelColor;
    UIColor* totalLabelColor;
    UIFont* fillLabelFont;
    UIFont* totalLabelFont;
    
    BOOL shouldShowTotalValue;
    BOOL shouldShowFillValue;
    
    UIColor* cylinderGradientColor;
    CGFloat cylinderGradientAlpha;
    
    CGFloat width;
    CGFloat height;
    CGFloat totalLabelHeight;
    CGFloat fillLabelHeight;
    
    CGFloat totalValue;
    CGFloat fillValue;
    NSString* totalValueText;
    NSString* fillValueText;
}

@end

@implementation CBCCylinderBudgetChartView

-(id)init {
    self = [super init];
    if(self) {
        [self setup];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self setup];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self setup];
    }
    return self;
}

-(void) reloadData {
    [self updateFromDataSource];
    [self updateFromDelegate];
    // reload    
    if(totalValue == 0) {
        fillValue = 0;
        totalValue = 1;
    }
    
    [totalLabel setHidden:YES];
    [fillLabel setHidden:YES];
    
    [UIView animateWithDuration:0.6 animations:^{
        backgroundView.backgroundColor = chartBackgroundColor;
        
        fillView.backgroundColor = chartFillColor;
        CGFloat fillHeight = height * fillValue / totalValue;
        [fillView setFrame:CGRectMake(0, height - fillHeight, width, fillHeight)];
        [fillView setBackgroundColor:chartFillColor];
        
    } completion:^(BOOL finished) {
        
        [self updateLabels];
        
        [totalLabel setHidden:NO];
        [fillLabel setHidden:NO];
    }];
}

# pragma mark Private Methods

- (void)loadDefaults {
    
    // setup
    totalValue = 0;
    fillValue = 0;
    
    shouldShowFillValue = YES;
    shouldShowTotalValue = YES;
    
    totalLabelHeight = 20;
    fillLabelHeight = 20;
    
    width = self.frame.size.width;
    height = self.frame.size.height;
    
    chartBackgroundColor = [UIColor whiteColor];
    chartFillColor = [UIColor greenColor];
    
    fillLabelColor = [UIColor darkTextColor];
    totalLabelColor = [UIColor darkTextColor];
    
    fillLabelFont = [UIFont systemFontOfSize:12];
    totalLabelFont = [UIFont systemFontOfSize:12];
    
    cylinderGradientColor = [UIColor blackColor];
    cylinderGradientAlpha = 0.2;
}

-(void)setup {
    [self loadDefaults];
    [self updateFromDelegate];
    
    self.backgroundColor = [UIColor clearColor];
    
    backgroundView = [UIView new];
    backgroundView.frame = self.bounds;
    
    gradientEffectView = [UIView new];
    gradientEffectView.userInteractionEnabled = NO;
    gradientEffectView.frame = self.bounds;
    gradientEffectView.backgroundColor = [UIColor clearColor];
    CALayer* gradientLayer = [self gradient];
    gradientLayer.frame =  gradientEffectView.bounds;
    [gradientEffectView.layer insertSublayer:gradientLayer atIndex:0];
    
    fillView = [UIView new];
    fillView.frame = CGRectMake(0, height, width, 0);
    
    totalLabel = [UILabel new];
    totalLabel.frame = CGRectMake(0, 0, width, totalLabelHeight);
    totalLabel.textAlignment = NSTextAlignmentCenter;
    
    fillLabel = [UILabel new];
    fillLabel.frame = CGRectMake(0, 0, width, fillLabelHeight);
    fillLabel.textAlignment = NSTextAlignmentCenter;
    
    [fillView addSubview:fillLabel];
    
    [self addSubview:backgroundView];
    [self addSubview:fillView];
    [self addSubview:totalLabel];
    [self addSubview:gradientEffectView];
    
    [backgroundView.layer setMasksToBounds:NO];
    [backgroundView.layer setShadowOffset:CGSizeMake(1, 5)];
    [backgroundView.layer setShadowRadius:5];
    [backgroundView.layer setShadowOpacity:0.5];
    
}


-(void) updateFromDataSource {
    if(self.dataSource != nil) {
        if([self.dataSource respondsToSelector:@selector(totalValueForChart:)]) {
            totalValue = [self.dataSource totalValueForChart:self];
        }
        
        if([self.dataSource respondsToSelector:@selector(fillValueForChart:)]) {
            fillValue = [self.dataSource fillValueForChart:self];
        }
        
        if([self.dataSource respondsToSelector:@selector(totalTextWithValue:ForChart:)]) {
            totalValueText = [self.dataSource totalTextWithValue:totalValue ForChart:self];
        } else {
            totalValueText = [NSString stringWithFormat:@"%.0f", totalValue];
        }
        
        if([self.dataSource respondsToSelector:@selector(fillTextWithValue:ForChart:)]) {
            fillValueText = [self.dataSource fillTextWithValue:fillValue ForChart:self];
        } else {
            fillValueText = [NSString stringWithFormat:@"%.0f", fillValue];
        }
    }
}

-(void) updateFromDelegate {
    if(self.delegate != nil) {
        if([self.delegate respondsToSelector:@selector(backgroundColorForChart:)]) {
            chartBackgroundColor = [self.delegate backgroundColorForChart:self];
        }
        
        if([self.delegate respondsToSelector:@selector(fillColorForChart:)]) {
            chartFillColor = [self.delegate fillColorForChart:self];
        }
        
        if([self.delegate respondsToSelector:@selector(totalValueFontForChart:)]) {
            totalLabelFont = [self.delegate totalValueFontForChart:self];
        }
        
        if([self.delegate respondsToSelector:@selector(fillValueFontForChart:)]) {
            fillLabelFont = [self.delegate fillValueFontForChart:self];
        }
        
        if([self.delegate respondsToSelector:@selector(totalValueFontColorForChart:)]) {
            totalLabelColor = [self.delegate totalValueFontColorForChart:self];
        }
        
        if([self.delegate respondsToSelector:@selector(fillValueFontColorForChart:)]) {
            fillLabelColor = [self.delegate fillValueFontColorForChart:self];
        }
        
        if([self.delegate respondsToSelector:@selector(totalValueHeightForChart:)]) {
            totalLabelHeight = [self.delegate totalValueHeightForChart:self];
        }
        
        if([self.delegate respondsToSelector:@selector(fillValueHeightForChart:)]) {
            totalLabelHeight = [self.delegate fillValueHeightForChart:self];
        }
        
        if([self.delegate respondsToSelector:@selector(shouldShowTotalValueForChart:)]) {
            shouldShowTotalValue = [self.delegate shouldShowTotalValueForChart:self];
        }
        
        if([self.delegate respondsToSelector:@selector(shouldShowFillValueForChart:)]) {
            shouldShowFillValue = [self.delegate shouldShowFillValueForChart:self];
        }
    }
}

- (void)updateLabels {
    [totalLabel setFrame:CGRectMake(0, -totalLabelHeight, width, totalLabelHeight)];
    totalLabel.textColor = totalLabelColor;
    totalLabel.font = totalLabelFont;
    
    [fillLabel setFrame:CGRectMake(0, fillView.frame.size.height / 2 - fillLabelHeight, width, fillLabelHeight)];
    fillLabel.textColor = fillLabelColor;
    fillLabel.font = fillLabelFont;
    
    if(shouldShowTotalValue) {
        [totalLabel setText: totalValueText];
    }
    else {
        [totalLabel setText:@""];
    }
    
    if(shouldShowFillValue) {
        [fillLabel setText: fillValueText];
    }
    else {
        [fillLabel setText:@""];
    }

}

- (CAGradientLayer*) gradient {
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat alpha;
    
    CGFloat radius = cylinderGradientAlpha;
    UIColor* color = cylinderGradientColor;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    
    UIColor *colorLeft = [UIColor colorWithRed:red green:green blue:blue alpha: radius];
    UIColor *colorLeft1 = [UIColor colorWithRed:red green:green blue:blue alpha: radius / 3];
    UIColor *colorMiddle = [UIColor colorWithRed:red green:green blue:blue alpha:0];
    UIColor *colorRight1 = [UIColor colorWithRed:red green:green blue:blue alpha:radius / 3];
    UIColor *colorRight = [UIColor colorWithRed:red green:green blue:blue alpha: radius];
    
    
    NSArray *colors = [NSArray arrayWithObjects:(id)colorLeft.CGColor, colorLeft1.CGColor, colorMiddle.CGColor, colorRight1.CGColor, colorRight.CGColor,nil];
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:0.25];
    NSNumber *stopThree = [NSNumber numberWithFloat:0.5];
    NSNumber *stopFour = [NSNumber numberWithFloat:0.75];
    NSNumber *stopFive = [NSNumber numberWithFloat:1];
    
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, stopThree, stopFour, stopFive, nil];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = colors;
    gradientLayer.locations = locations;
    
    gradientLayer.startPoint = CGPointMake(0, 0.5);
    gradientLayer.endPoint = CGPointMake(1.0, 0.5);
    
    return gradientLayer;
}

@end
