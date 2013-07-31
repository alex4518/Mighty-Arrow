//
//  Level1.m
//  Mighty Sword
//
//  Created by alex on 20/07/2013.
//  Copyright 2013 alex. All rights reserved.
//

#import "Level1.h"
#import "MainMenuLayer.h"
#import "Skeleton.h"
#import "Spider.h"
#import "Lizard.h"
#import "Boss.h"


@implementation Level1

static Level1* Level1Layer;
+(Level1*) Level1Layer
{
	NSAssert(Level1Layer != nil, @"GameScene instance not yet initialized!");
	return Level1Layer;
}

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        
        Level1Layer = self;
        
        self.themap = [CCTMXTiledMap tiledMapWithTMXFile:@"lev306.tmx"];
        self.bgLayer = [self.themap layerNamed:@"Background"];
        self.metaLayer = [self.themap layerNamed:@"Meta"];
        self.metaLayer.visible = NO;

        [self addChild:self.themap z:-1];
    }
    
    
    
    CCTMXObjectGroup *objectGroup = [self.themap objectGroupNamed:@"Objects"];
    NSAssert(objectGroup != nil, @"tile map has no objects object layer");
    
    NSDictionary *spawnPoint;
    
    for (spawnPoint in [objectGroup objects]) {
        if ([[spawnPoint valueForKey:@"Enemy"] intValue] == 1){
            int x = [spawnPoint[@"x"] integerValue]/2;
            int y = [spawnPoint[@"y"] integerValue]/2;

            Skeleton* skel = [Skeleton skeleton];
            [skel setPosition:ccp(x,y)];
            [self addChild:skel];            
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

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
    HUDLayer *hud = [HUDLayer node];
    
    Level1 *layer = [[Level1 alloc] initWithHUD:hud];
	
	// add layer as a child to scene
	[scene addChild: layer];
    
    InputLayer* inputLayer=[InputLayer node];
    [scene addChild:inputLayer z:1];
    
    [scene addChild:hud z:1];
    
    CCMenuItem *Pause = [CCMenuItemImage itemWithNormalImage:@"pause.png"
                                               selectedImage: @"pause.png"
                                                      target:Level1Layer
                                                    selector:@selector(pause:)];
    CCMenu *PauseButton = [CCMenu menuWithItems: Pause, nil];
    PauseButton.position = ccp(30, 300);
    [scene addChild:PauseButton z:1000];
	
	// return the scene
	return scene;
}


@end
