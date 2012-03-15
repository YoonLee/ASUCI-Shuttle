//
//  BUSLocationShareCenter.m
//  BUS
//
//  Created by Yoon Lee on 3/14/12.
//  Copyright 2012 University of California, Irvine. All rights reserved.
//

#import "BUSLocationShareCenter.h"


@interface BUSLocationShareCenter()

- (void) scheduleUpdate:(id)timer;

@property(nonatomic, retain) NSMutableArray *busAnnotations;

@property(nonatomic, retain) SBJsonStreamParser *parser;

@property(nonatomic, retain) SBJsonStreamParserAdapter *streamParserAdapter;

@property(nonatomic, retain) NSArray *busInfo;

@end

@implementation BUSLocationShareCenter
@synthesize busAnnotations;
@synthesize parser, streamParserAdapter;
@synthesize busInfo;




BUSLocationShareCenter *sharedBUSLocation;

+ (id) initSahredBUSLocation
{
	if (!sharedBUSLocation) 
	{
		sharedBUSLocation = [[[BUSLocationShareCenter alloc] init] retain];
	}
	
	return sharedBUSLocation;
}

- (void) parseSelectedRoute:(int)route
{
	[self setParser:[[SBJsonStreamParser alloc] init]];
	streamParserAdapter = [[SBJsonStreamParserAdapter alloc] init];
	[streamParserAdapter setDelegate:self];
	[parser setDelegate:streamParserAdapter];
	
	NSString *uriString = [NSString stringWithFormat:@"http://www.ucishuttles.com/Route/%d/Vehicles", route];
	uriString = [uriString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSURL *uri = [NSURL URLWithString:uriString];
	NSURLRequest *requestURI = [[NSURLRequest alloc] initWithURL:uri];
	NSURLConnection *connection = [[[NSURLConnection alloc] initWithRequest:requestURI delegate:self] autorelease];
	[connection start];
	[requestURI release];
}

#pragma mark NSURLConnectionDelegate
// failure case
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	errAlertView([error description]);
}

// message receiving should append a data
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	SBJsonStreamParserStatus status = [self.parser parse:data];
	
	switch (status)
	{
		case SBJsonStreamParserError:
			// fatal error
			errAlertView(parser.error);
			break;
		case SBJsonStreamParserWaitingForData:
			// pass
			break;
	}
}

// after receiving the one result
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSLog(@"FINISHES");
	if (!busAnnotations)
	{
		busAnnotations = [[NSMutableArray alloc] init];
		
		for (NSDictionary *dict in self.busInfo)
		{
			BUSAnnotation *bAnnotation = [[BUSAnnotation alloc] init];
			NSDictionary *coordinate = [dict objectForKey:@"Coordinate"];
			[bAnnotation setLatitude:[(NSString*)[coordinate objectForKey:@"Latitude"] doubleValue]];
			[bAnnotation setLongitude:[(NSString*)[coordinate objectForKey:@"Longitude"] doubleValue]];
			[bAnnotation setBusNumber:[(NSString*)[dict objectForKey:@"Name"] intValue]];
			[bAnnotation setHeading:[dict objectForKey:@"Heading"]];
			[busAnnotations addObject:bAnnotation];
			[bAnnotation release];
			NSLog(@"%@", [bAnnotation description]);
		}
	}
	else
	{
		// case 1: new bus added
		if ([self.busInfo count] == [self.busAnnotations count])
		{
			int i = 0;
			// update the information
			for (NSDictionary *dict in self.busInfo)
			{
				BUSAnnotation *bAnnotation = [busAnnotations objectAtIndex:i];
				NSDictionary *coordinate = [dict objectForKey:@"Coordinate"];
				[bAnnotation setLatitude:[(NSString*)[coordinate objectForKey:@"Latitude"] doubleValue]];
				[bAnnotation setLongitude:[(NSString*)[coordinate objectForKey:@"Longitude"] doubleValue]];
				[bAnnotation setBusNumber:[(NSString*)[dict objectForKey:@"Name"] intValue]];
				[bAnnotation setHeading:[dict objectForKey:@"Heading"]];
				NSLog(@"%@", [bAnnotation description]);
				i ++;
			}
		}
		// case 2: bus removed
		// case 3: no bus
	}
}

#pragma mark SBJsonParserDelegate
- (void)parser:(SBJsonStreamParser *)parser foundArray:(NSArray *)array 
{
	// bus info is the object of array, it will automatically retains the object count
	[self setBusInfo:array];
}

- (void)parser:(SBJsonStreamParser *)parser foundObject:(NSDictionary *)dict 
{
	NSLog(@"hash = %@", [dict description]);
}

- (void) dealloc
{
	[busAnnotations release];
	busAnnotations = nil;
	[self.parser release];
	self.parser = nil;
	[super dealloc];
}

@end
