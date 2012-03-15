//
//  BUSAppDelegate.m
//  BUS
//
//  Created by Yoon Lee on 3/14/12.
//  Copyright 2012 University of California, Irvine. All rights reserved.
//

#import "BUSAppDelegate.h"

@implementation BUSAppDelegate

@synthesize window;
@synthesize naviController, busMap;


#pragma mark -
#pragma mark Application lifecycle
BOOL shouldStop;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{        
    // Override point for customization after application launch.
    [self setWindow:[[UIWindow alloc] initWithFrame:deviceScreen()]];
	busMap = [[[BUSMapVC alloc] init] autorelease];
	self.naviController = [[UINavigationController alloc] initWithRootViewController:busMap];
	
	UIButton *bttn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[bttn addTarget:self action:@selector(ruleIT:) forControlEvents:UIControlEventTouchUpInside];
	[bttn setTitle:@"ROUTE THIS!" forState:UIControlStateNormal];
	[bttn setFrame:CGRectMake(0, 0, 140, 20)];
	[bttn setCenter:CGPointMake(deviceScreen().size.width/2, deviceScreen().size.height/2)];
	[busMap.view addSubview:bttn];
	
	[self.window addSubview:self.naviController.view];
    [self.window makeKeyAndVisible];
	shouldStop = true;
	
    return YES;
}

- (void)ruleIT:(id)sender
{
	shouldStop = !shouldStop;
	
	if (!shouldStop)
	{
		[[BUSLocationShareCenter initSahredBUSLocation] parseSelectedRoute:176];
		[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(scheduleTick:) userInfo:nil repeats:YES];
	}
}

- (void)scheduleTick:(NSTimer*)timer
{
	if (shouldStop)
	{
		[timer invalidate];
		return;
	}
	
	NSLog(@"tick tick mofo!!!");
	[[BUSLocationShareCenter initSahredBUSLocation] parseSelectedRoute:176];
}

- (void)applicationWillResignActive:(UIApplication *)application 
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application 
{
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application 
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application 
{
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application 
{
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc 
{
	[naviController release];
    [window release];
    [super dealloc];
}


@end
