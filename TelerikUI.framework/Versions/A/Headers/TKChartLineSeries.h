//
//  TKChartLineSeries.h
//  TelerikUI
//
//  Copyright (c) 2013 Telerik. All rights reserved.
//

#import "TKChartSeries.h"

/**
 Represents TKChart line series. Check this [Guide](chart-series-line) for more information.
 
 <img src="../docs/images/chart-series-line001.png">
 
 @see [Working with TKChartLineSeries](chart-series-line)
 
 */
@interface TKChartLineSeries : TKChartSeries

/**
 If distance between hit and line is bigger, the selection is cleared. By default, it is 25 pixels.
 */
@property (nonatomic, assign) CGFloat marginForHitDetection;

/**
 Determines whether gaps should be displayed when there are nil values.
 */
@property (nonatomic) BOOL displayNilValuesAsGaps;

@end
