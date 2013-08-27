//
//  Level4.m
//  Mighty Sword
//
//  Created by alex on 31/07/2013.
//  Copyright (c) 2013 alex. All rights reserved.
//

#import "Level3.h"
#import "Level4.h"
#import "SmallPotion.h"
#import "LargePotion.h"
#import "Spider.h"
#import "Skeleton.h"
#import "Boss.h"
#import "EndSceneLayer.h"
#import "SimpleAudioEngine.h"

@implementation Level4

static Level4* Level4Layer;
+(Level4*) Level4Layer
{
	NSAssert(Level4Layer != nil, @"GameScene instance not yet initialized!");
	return Level4Layer;
}

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        
        Level4Layer = self;
        
        self.themap = [CCTMXTiledMap tiledMapWithTMXFile:@"lev_41.tmx"];
        self.bgLayer = [self.themap layerNamed:@"Background"];
        self.metaLayer = [self.themap layerNamed:@"Meta"];
        self.metaLayer.visible = NO;
        
        [self addChild:self.themap z:-1];
    }
    
    GameLayer* game = [GameLayer sharedGameLayer];
    
    Hero* hero = [game defaultHero];
    
    Level3* lev3 = [Level3 Level3Layer];
    
    hero.heroDamageFromLevelUp = lev3.damage;
    hero.level = lev3.lev;
    hero.heroHealth = lev3.health;
    hero.currentXP = lev3.xp;
    
    CCTMXObjectGroup *objectGroup = [self.themap objectGroupNamed:@"Objects"];
    NSAssert(objectGroup != nil, @"tile map has no objects object layer");
    
    NSDictionary *spawnPoint;
    
    for (spawnPoint in [objectGroup objects]) {
        if ([[spawnPoint valueForKey:@"Boss"] intValue] == 1){
            int x = [spawnPoint[@"x"] integerValue]/2;
            int y = [spawnPoint[@"y"] integerValue]/2;
            
            Boss* boss = [Boss boss];
            boss.tag = 2;
            [boss setPosition:ccp(x,y)];
            [self addChild:boss];
        }
    }
    
    for (spawnPoint in [objectGroup objects]) {
        if ([[spawnPoint valueForKey:@"Spider"] intValue] == 1){
            int x = [spawnPoint[@"x"] integerValue]/2;
            int y = [spawnPoint[@"y"] integerValue]/2;
            
            Spider* spider = [Spider spider];
            [spider setPosition:ccp(x,y)];
            [self addChild:spider];
        }
    }
    
    for (spawnPoint in [objectGroup objects]) {
        if ([[spawnPoint valueForKey:@"SmallPotions"] intValue] == 1){
            int x = [spawnPoint[@"x"] integerValue]/2;
            int y = [spawnPoint[@"y"] integerValue]/2;
            
            SmallPotion* small = [SmallPotion smallPotion];
            [small setPosition:ccp(x,y)];
            [self addChild:small];
        }
    }
    
    for (spawnPoint in [objectGroup objects]) {
        if ([[spawnPoint valueForKey:@"LargePotions"] intValue] == 1){
            int x = [spawnPoint[@"x"] integerValue]/2;
            int y = [spawnPoint[@"y"] integerValue]/2;
            
            LargePotion* large = [LargePotion largePotion];
            [large setPosition:ccp(x,y)];
            [self addChild:large];
        }
    }
    
    
    
    for (spawnPoint in [objectGroup objects]) {
        if ([[spawnPoint valueForKey:@"exits"] intValue] == 1){
            
            self.exitRect = CGRectMake([spawnPoint[@"x"] floatValue]/2, [spawnPoint[@"y"] floatValue]/2,
                                       [spawnPoint[@"x"] floatValue]/2 + [spawnPoint[@"width"] floatValue]/2,+ [spawnPoint[@"y"] floatValue]/2 + [spawnPoint[@"height"] floatValue]/2);
        }
    }
    
    
    return self;
    
}

-(Boss*) defaultBoss
{
	CCNode* node = [self getChildByTag:2];
	return (Boss*)node;
}

- (void) update:(ccTime)delta {
    
    [self.delegate setJoystickToHero];
    [_hud setStatusString:[NSString stringWithFormat:@"Level: %d", [self defaultHero].level]];
    
    
    if ([self defaultBoss].health <= 0) {
        
        [[CCDirector sharedDirector] replaceScene:[EndSceneLayer scene]];
        
    }
}

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
    HUDLayer *hud = [HUDLayer node];
    
    Level4 *layer = [[Level4 alloc] initWithHUD:hud];
	
	// add layer as a child to scene
	[scene addChild: layer];
    
    InputLayer* inputLayer=[InputLayer node];
    [scene addChild:inputLayer z:1];
    
    [scene addChild:hud z:1];
    
    CCMenuItem *Pause = [CCMenuItemImage itemWithNormalImage:@"pause.png"
                                               selectedImage: @"pause.png"
                                                      target:Level4Layer
                                                    selector:@selector(pause:)];
    CCMenu *PauseButton = [CCMenu menuWithItems: Pause, nil];
    PauseButton.position = ccp(30, 300);
    [scene addChild:PauseButton z:1000];
	
	// return the scene
	return scene;
}



@end
