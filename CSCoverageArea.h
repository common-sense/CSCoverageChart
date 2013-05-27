//
//  CSCoverageArea.h
//
//
//  Created by Marco Brambilla on 26/05/13.
//  Copyright (c) 2013 CommonSense. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSCoverageArea : NSObject
@property CGFloat scaleLinesCount;
@property CGFloat lineWidth;
@property (nonatomic, strong) UIColor* lineColor;
@property CGFloat selectedLineWidth;

@end
