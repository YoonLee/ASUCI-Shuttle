//
//  BUSLocationShareCenter.h
//  BUS
//
//  Created by Yoon Lee on 3/14/12.
//  Copyright 2012 University of California, Irvine. All rights reserved.
//
#import "SBJson.h"
#import "BUSAnnotation.h"


@class BUSAnnotation;
@interface BUSLocationShareCenter : NSObject <SBJsonStreamParserAdapterDelegate>

+ (id) initSahredBUSLocation;

- (void) parseSelectedRoute:(int)route;

@end
