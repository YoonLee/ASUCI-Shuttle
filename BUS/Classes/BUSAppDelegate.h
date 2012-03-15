//
//  BUSAppDelegate.h
//  BUS
//
//  Created by Yoon Lee on 3/14/12.
//  Copyright 2012 University of California, Irvine. All rights reserved.
//
#import "BUSMapVC.h"

@class BUSMapVC;
@interface BUSAppDelegate : NSObject <UIApplicationDelegate> 
{
    UIWindow *window;
	BUSMapVC *busMap;
	UINavigationController *naviController;
}

@property(nonatomic, retain) UIWindow *window;
@property(nonatomic, retain) UINavigationController *naviController;
@property(nonatomic, retain) BUSMapVC *busMap;

@end

