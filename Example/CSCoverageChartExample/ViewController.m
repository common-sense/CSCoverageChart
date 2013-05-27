//
//  ViewController.m
//  CSCoverageChartExample
//
//  Created by Marco Brambilla on 27/05/13.
//  Copyright (c) 2013 CommonSense. All rights reserved.
//

#import "ViewController.h"
#import "CSCoverageChart.h"

@interface ViewController ()
@property (nonatomic,strong) CSCoverageChart* coverage;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.coverage = [[CSCoverageChart alloc] initWithFrame:CGRectMake(0,0, 600, 600)];
    
    self.coverage.center = self.view.center;
    self.coverage.delegate = self;
    
    [self.view addSubview:self.coverage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - chart delegate methods

- (float)maximumRadiusForChart:(CSCoverageChart *)chart {
    return self.coverage.bounds.size.width/2 - 10; //10px margin
}

- (CSCoverageArea *)coverageAreaForChart:(CSCoverageChart *)chart {
    CSCoverageArea* area = [[CSCoverageArea alloc] init];
    area.scaleLinesCount = 4;
    area.lineColor = [UIColor grayColor];
    area.lineWidth = 1;
    area.selectedLineWidth = 4;
    return area;
}
- (int)numberOfSlicesForChart:(CSCoverageChart *)chart {
    return 3;
}
- (CSCoverageSlice *)coverageChart:(CSCoverageChart *)chart sliceForIndex:(int)index {
    
    CSCoverageSlice* slice = [[CSCoverageSlice alloc] init];
    if (index == 0) {
        slice.fillColor = [[UIColor yellowColor] colorWithAlphaComponent:0.3];
        slice.strokeColor = [UIColor darkGrayColor];
        slice.value = 0.5;
    } else if (index == 1) {
        slice.fillColor = [[UIColor blueColor] colorWithAlphaComponent:0.3];
        slice.strokeColor = [UIColor darkGrayColor];
        slice.value = 0.35;
    } else if (index == 2) {
        slice.fillColor = [[UIColor greenColor] colorWithAlphaComponent:0.3];
        slice.strokeColor = [UIColor darkGrayColor];
        slice.value = 0.8;
    }
    
    return slice;
}

@end
