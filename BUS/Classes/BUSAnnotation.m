//
//  BUSAnnotation.m
//  BUS
//
//  Created by Yoon Lee on 3/14/12.
//  Copyright 2012 University of California, Irvine. All rights reserved.
//

#import "BUSAnnotation.h"


@implementation BUSAnnotation
@synthesize latitude, longitude, busNumber;
@synthesize heading;


// over writing
- (CLLocationCoordinate2D)coordinate;
{
	CLLocationCoordinate2D theCoordinate = CLLocationCoordinate2DMake(self.latitude, self.longitude);
	
    return theCoordinate; 
}

// over writing
- (NSString *)title
{
    return [NSString stringWithFormat:@"%@", busNumber];
}

- (NSString *)subtitle
{
	return [NSString stringWithFormat:@"%@", heading];
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"\nlocation: %f&%f\nbus number: %d\nhead: %@", latitude, longitude, busNumber, heading];
}

- (void) dealloc
{
	[super dealloc];
}

@end

@implementation BUSAnnotationView


- (void)drawRect:(CGRect)rect
{
	
}

- (void) setAnnotation:(id <MKAnnotation>)_annotation
{
	[super setAnnotation:_annotation];
	[self setNeedsDisplay];
}

- (void) dealloc
{
	[super dealloc];
}

@end