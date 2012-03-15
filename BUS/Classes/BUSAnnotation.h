//
//  BUSAnnotation.h
//  BUS
//
//  Created by Yoon Lee on 3/14/12.
//  Copyright 2012 University of California, Irvine. All rights reserved.
//
#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>


@interface BUSAnnotation : NSObject <MKAnnotation>
{
	double latitude, longitude;
	int busNumber;
	
	NSString *heading;
}

@property(nonatomic, assign) double latitude;
@property(nonatomic, assign) double longitude;
@property(nonatomic, assign) int busNumber;
@property(nonatomic, retain) NSString *heading;

@end

@interface BUSAnnotationView : MKAnnotationView
{
	
}

@end