/*
 *  AppConfig.h
 *  BUS
 *
 *  Created by Yoon Lee on 3/14/12.
 *  Copyright 2012 University of California, Irvine. All rights reserved.
 *
 */
#import "BUSLocationShareCenter.h"


static inline CGRect deviceScreen()
{
	return [UIScreen mainScreen].bounds;
}

static inline UIView* createBaseView()
{
	return [[[UIView alloc] initWithFrame:deviceScreen()] autorelease];
}

static inline void errAlertView(NSString *msg)
{
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}