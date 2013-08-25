//
//  HUDLayer.m
//  Mighty Sword
//
//  Created by Panos Albanis on 14/07/2013.
//  Copyright (c) 2013 alex. All rights reserved.
//

#import "HUDLayer.h"
#import "Hero.h"
#import "GameLayer.h"
#import "Constants.h"

@implementation HUDLayer

- (id)init {
    
    if ((self = [super init])) {
        
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        _label = [CCLabelTTF labelWithString:@"Character" fontName:@"arial" fontSize:20];
        
        _statusLabel = [CCLabelTTF labelWithString:@"" fontName:@"arial" fontSize:20];
        
        _statusLabel.position = ccp(winSize.width * 0.85, winSize.height * 0.9);
        _label.position = ccp(winSize.width * 0.85, winSize.height * 0.97);
        [self addChild:_statusLabel];
        [self addChild:_label];
        
        healthBar = [CCSprite spriteWithFile:@"health-bar.png"];
        healthBar.position = CGPointMake(winSize.width * 0.18, winSize.height * 0.93);
        
        progressTimer = [CCProgressTimer progressWithSprite:healthBar];
        progressTimer.type = kCCProgressTimerTypeBar;
        progressTimer.percentage = kHeroHealth;
        progressTimer.midpoint = ccp(0,0);
        progressTimer.barChangeRate = ccp(1,0);
        progressTimer.position = CGPointMake(winSize.width * 0.18, winSize.height * 0.93);

        
        [self addChild:progressTimer];


        //[self addChild:healthBar];
        
        [self scheduleUpdate];

    }
    return self;
}

- (void)setStatusString:(NSString *)string {
    _statusLabel.string = string;
}

- (void) update:(ccTime)delta {
    
    GameLayer* game = [GameLayer sharedGameLayer];
    
    Hero* hero = [game defaultHero];
    
    //healthBar.scaleX = hero.heroHealth / (float)kHeroHealth;
    progressTimer.percentage = hero.heroHealth;
}

@end
