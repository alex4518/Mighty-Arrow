//
//  Hero.m
//  cocos
//
//  Created by alex on 24/05/2013.
//  Copyright (c) 2013 alex. All rights reserved.
//

#import "Hero.h"
#import "GameLayer.h"
#import "InputLayer.h"


@interface Hero (PrivateMethods)
-(id) initWithHeroImage;
@end

@implementation Hero

+(id) hero
{
	return [[self alloc] initWithHeroImage];
}

-(id) initWithHeroImage
{
	// Loading the Hero's sprite using a sprite frame name (eg the filename)
	if ((self = [super initWithFile:@"right.png"]))
	{
        [self scheduleUpdate];

	}
	return self;
}





@end
