//
//  LargePotion.m
//  Mighty Sword
//
//  Created by Alexandros Almpanis on 22/07/2013.
//  Copyright (c) 2013 alex. All rights reserved.
//

#import "LargePotion.h"
#import "Hero.h"
#import "GameLayer.h"

@implementation LargePotion

+(id) largePotion
{
	return [[self alloc] initWithPotionImage];
}

-(id) initWithPotionImage
{
    if ((self = [super initWithFile:@"large-potion.png"]))
	{
        [self scheduleUpdate];
	}
	return self;
}

-(CGRect) potionBoundingBox {
    
    return self.boundingBox;
}

-(void) update:(ccTime)delta {
    
    
    
    GameLayer* game = [GameLayer sharedGameLayer];
    
    Hero* hero = [game defaultHero];
    
    if (CGRectIntersectsRect(self.potionBoundingBox, hero.heroBoundingBox )) {
        
        [game removeChild:self cleanup:YES];
        
        hero.heroHealth = kHeroHealth;
    }
}

@end
