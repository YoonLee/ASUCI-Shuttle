//
//  BUSMapVC.m
//  BUS
//
//  Created by Yoon Lee on 3/14/12.
//  Copyright 2012 University of California, Irvine. All rights reserved.
//

#import "BUSMapVC.h"


@implementation BUSMapVC



- (void)loadView 
{
	[self setView:createBaseView()];
	[self.view setBackgroundColor:[UIColor redColor]];
	MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, deviceScreen().size.width, deviceScreen().size.height - 108.5)];
	[mapView setMapType:MKMapTypeStandard];
	[mapView setShowsUserLocation:YES];
	
	MKCoordinateRegion campusRegion;
	campusRegion.center.latitude = 33.646116;
	campusRegion.center.longitude = -117.842875;
	campusRegion.span.latitudeDelta = 0.0162872;
	campusRegion.span.longitudeDelta = 0.0169863;
	[mapView setRegion:campusRegion animated:YES];
	[self.view addSubview:mapView];
	[mapView release];
	
	UINavigationBar *naviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, deviceScreen().size.height-108.5, deviceScreen().size.width, 44)];
	[self.view addSubview:naviBar];
	[naviBar release];
	
	
	UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 7, 220, 30)];
	label1.text = @"Anteater Express";
	label1.textAlignment = UITextAlignmentLeft;
	label1.textColor = [UIColor whiteColor];
	label1.font = [UIFont boldSystemFontOfSize:14];
	label1.backgroundColor = [UIColor clearColor];
	UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(5, 20, 220, 30)];
	label2.text = @"Select the route in the bottom";
	label2.textAlignment = UITextAlignmentLeft;
	label2.textColor = [UIColor whiteColor];
	label2.font = [UIFont fontWithName:@"Georgia" size:12];
	label2.backgroundColor = [UIColor clearColor];
	UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 220, 60)];
	[imgView addSubview:label2];
	[imgView addSubview:label1];
	self.navigationItem.titleView = imgView;
	[imgView release];
	[label1 release];
	[label2 release];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning 
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload 
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc 
{
    [super dealloc];
}


@end
