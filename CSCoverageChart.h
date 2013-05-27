//
//  CSCoverageIndicator.h
//
//
//  Created by Marco Brambilla on 26/05/13.
//  Copyright (c) 2013 CommonSense. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSCoverageSlice.h"
#import "CSCoverageArea.h"
@class CSCoverageChart;

@protocol CSCoverageChartDelegate <NSObject>

- (int)numberOfSlicesForChart:(CSCoverageChart*)chart;
- (CSCoverageSlice*)coverageChart:(CSCoverageChart*)chart sliceForIndex:(int)index;
- (CSCoverageArea*)coverageAreaForChart:(CSCoverageChart*)chart;
- (float)maximumRadiusForChart:(CSCoverageChart*)chart;

@end

@interface CSCoverageChart : UIControl

@property (nonatomic, weak) id<CSCoverageChartDelegate> delegate;
@property int selectedIndex;

- (void)reloadData;
- (void)setValue:(CGFloat)value forSliceIndex:(int)index;
- (CSCoverageArea*)area;
- (NSArray*)slices;

@end
