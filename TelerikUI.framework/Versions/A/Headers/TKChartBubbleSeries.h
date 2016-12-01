//
//  TKChartBubbleSeries.h
//  TelerikUI
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

#import "TKChartScatterSeries.h"

/**
 Represents a TKChart bubble series. See TKChartScatterSeries for more information. Also check this [Guide](chart-series-bubble).
 
 <img src="../docs/images/chart-series-bubble001.png">
 
 @see [Working with TKChartAreaSeries](chart-series-bubble)
 
 */
@interface TKChartBubbleSeries : TKChartScatterSeries
/**
 A scale that will be used when calculating bubbles diameter.
 */
@property (nonatomic, strong) NSNumber * __nullable scale;

/**
 A value that represents the diameter of the biggest bubble when scale property is not set.
 */
@property (nonatomic, strong) NSNumber * __nullable biggestBubbleDiameterForAutoscale;

@end
