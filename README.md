CSCoverageChart
===============

This control draws a pie chart with multiple slices at even angles, each slice can have different radius. 
Useful when displaying coverage data.

<img width=500 src="https://raw.github.com/common-sense/CSCoverageChart/master/sample.png"/>


Sample code
-----------

Create and add a new chart:

    CSCoverageChart coverage = [[CSCoverageChart alloc] initWithFrame:CGRectMake(0,0, 600, 600)];
    
    coverage.center = self.view.center;
    coverage.delegate = self;
    
    [self.view addSubview:coverage];
    
Declare delegate implementation:

    @interface ViewController : UIViewController<CSCoverageChartDelegate>


Implement delegate methods:

    - (int)numberOfSlicesForChart:(CSCoverageChart*)chart;
    - (CSCoverageSlice*)coverageChart:(CSCoverageChart*)chart sliceForIndex:(int)index;
    - (CSCoverageArea*)coverageAreaForChart:(CSCoverageChart*)chart;
    - (float)maximumRadiusForChart:(CSCoverageChart*)chart;

Slice and chart area objects
----------------------------------
Each slice is an CSCoverageSlice object: 

    CSCoverageSlice* slice = [[CSCoverageSlice alloc] init];
    slice.fillColor = [[UIColor blueColor] colorWithAlphaComponent:0.3];
    slice.strokeColor = [UIColor darkGrayColor];
    slice.value = 0.35;

The _value_ property is a float value ranging from 0 to 1, defining the actual radius of the slice as a fraction of the maximum radius.

Chart area settings are defined using a CSCoverageArea object.

    CSCoverageArea* area = [[CSCoverageArea alloc] init];
    area.scaleLinesCount = 4;
    area.lineColor = [UIColor grayColor];
    area.lineWidth = 1;
    area.selectedLineWidth = 4;
    
Acknowledgements
----------------

© 2013, CommonSense srl. Released under the [MIT 
License](http://www.opensource.org/licenses/mit-license.php).

