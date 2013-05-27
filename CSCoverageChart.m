//
//  CSCoverageIndicator.m
//
//
//  Created by Marco Brambilla on 26/05/13.
//  Copyright (c) 2013 CommonSense. All rights reserved.
//

#import "CSCoverageChart.h"

@interface CSCoverageChart ()
@property CGFloat maximumRadius;
@property CSCoverageArea* area;
@property NSMutableArray* slicesArray;
@property int slicesCount;
@end

@implementation CSCoverageChart
{
    BOOL setupCompleted;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        setupCompleted = NO;
        self.selectedIndex = -1;
        self.slicesArray = [NSMutableArray array];
    }
    return self;
}

- (void)setupGraph {
    if (!setupCompleted) {
        
        if (self.delegate) {
            self.area = [self.delegate coverageAreaForChart:self];
            self.slicesCount = [self.delegate numberOfSlicesForChart:self];
        }
        
        [self reloadData];

        setupCompleted = YES;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];

    if (self.delegate) {
        self.maximumRadius = [self.delegate maximumRadiusForChart:self];
    }

    [self setupGraph];
}

- (void)reloadData {
    if (!self.delegate) {
        return;
    }
    
    [self.slicesArray removeAllObjects];
    
    for (int i = 0; i < self.slicesCount; i++) {
        CSCoverageSlice* slice = [self.delegate coverageChart:self sliceForIndex:i];
        if (slice != nil) {
            [self.slicesArray addObject:slice];
        }
    }
}

- (void)setValue:(CGFloat)value forSliceIndex:(int)index {
    CSCoverageSlice* slice = [[self slices] objectAtIndex:index];
    slice.value = value;
    
    [self setNeedsDisplay];
}

- (NSArray*)slices {
    return [self slicesArray];
}

- (void)drawArea {
    CGPoint center = CGPointMake(self.bounds.size.height / 2, self.bounds.size.width / 2);
    UIBezierPath *circle = [UIBezierPath bezierPath]; //empty path
    
    [circle setLineWidth:self.area.lineWidth];
    [circle addArcWithCenter:center
                      radius:self.maximumRadius
                  startAngle:0
                    endAngle:2*M_PI
                   clockwise:YES]; //add the arc
    
    [circle closePath];
    [self.area.lineColor set];
    [circle stroke];

    float scaleGapSize = self.maximumRadius / (self.area.scaleLinesCount);
    float progress = scaleGapSize;
    while (progress < self.maximumRadius) {
        UIBezierPath *innerCircle = [UIBezierPath bezierPath]; //empty path
        [innerCircle setLineWidth:self.area.lineWidth];
        [innerCircle addArcWithCenter:center
                          radius:progress
                      startAngle:0
                        endAngle:2*M_PI
                       clockwise:YES]; //add the arc
        [innerCircle closePath];
        [self.area.lineColor set];
        float dashPattern[] = {5 * self.area.lineWidth, 5 * self.area.lineWidth}; //make your pattern here
        [innerCircle setLineDash:dashPattern count:1 phase:1];
        [innerCircle stroke];

        progress = progress + scaleGapSize;
    }

    

}

- (void)drawSliceOfPie:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle fillColor:(UIColor *)fillColor strokeColor:(UIColor *)strokeColor lineWidth:(CGFloat)lineWidth
{
    //draw arc
    CGPoint center = CGPointMake(self.bounds.size.height / 2, self.bounds.size.width / 2);
    UIBezierPath *arc = [UIBezierPath bezierPath]; //empty path
    [arc setLineWidth:lineWidth];
    [arc moveToPoint:center];
    CGPoint next;
    next.x = center.x + radius * cos(startAngle);
    next.y = center.y + radius * sin(startAngle);
    [arc addLineToPoint:next]; //go one end of arc
    
    [arc addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES]; //add the arc
    [arc addLineToPoint:center]; //back to center
    
    [fillColor set];
    [arc fill];
    [strokeColor set];
    [arc stroke];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [self drawArea];

    for (int index = 0; index < [self.slices count]; index++) {

        CSCoverageSlice* slice = [self.slices objectAtIndex:index];
        
        CGFloat sliceAngle = 2*M_PI / [self.slices count];
        
        CGFloat startAngle = index*sliceAngle ; //1 pm = 1/6 rad
        CGFloat endAngle = (index+1)*sliceAngle;
        
        
        CGFloat width = self.area.lineWidth;
        if (self.selectedIndex == index) {
            width = self.area.selectedLineWidth;
        }
        
        CGFloat actualRadius = slice.value * self.maximumRadius;

        
        [self drawSliceOfPie:actualRadius
                  startAngle:startAngle
                    endAngle:endAngle
                   fillColor:slice.fillColor
                 strokeColor:slice.strokeColor
                   lineWidth:width];

    }

}

/*
- (float)radians:(float)degrees {
    return degrees*M_PI / 180;
}*/

@end
