//
//  SmallPotion.m
//  Mighty Sword
//
//  Created by alex on 22/07/2013.
//  Copyright (c) 2013 alex. All rights reserved.
//

#import "SmallPotion.h"
#import "Hero.h"
#import "GameLayer.h"

@implementation SmallPotion

+(id) smallPotion
{
	return [[self alloc] initWithPotionImage];
}

-(id) initWithPotionImage
{
    if ((self = [super initWithFile:@"small-potion.png"]))
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
        
        if (hero.heroHealth + kHeroHealth*50/100 >= kHeroHealth) {
            
            hero.heroHealth = kHeroHealth;
        }
        else {
            hero.heroHealth = hero.heroHealth + kHeroHealth*50/100;
        }
    }    
}

@end
