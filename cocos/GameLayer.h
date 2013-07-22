//
//  GameLayer.h
//  cocos
//
//  Created by alex on 06/03/2013.
//  Copyright alex 2013. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "HUDLayer.h"
#import "SneakyJoystick.h" 
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "SneakyJoystickSkinnedBase.h"
#import "Hero.h"
#import "SmallPotion.h"
#import "LargePotion.h"


@protocol GameLayerProtocol <NSObject>

-(void) setJoystickToHero;

@end


// GameLayer
@interface GameLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    CCTMXTiledMap *themap ;
    CCTMXLayer *bgLayer ;
    HUDLayer * _hud;
}

@property(nonatomic,strong) CCTMXTiledMap *themap;
@property(nonatomic,strong) CCTMXLayer *bgLayer ;

@property(nonatomic,strong) id <GameLayerProtocol> delegate;

-(Hero*) defaultHero;
- (id)initWithHUD:(HUDLayer *)hud;
+(GameLayer*) sharedGameLayer;



// returns a CCScene that contains the GameLayer as the only child
+(CCScene *) scene;

- (BOOL)isWallAtTileCoord:(CGPoint)tileCoord;


- (CGPoint)tileCoordForPosition:(CGPoint)position;
- (CGPoint)positionForTileCoord:(CGPoint)tileCoord;

- (NSArray *)walkableAdjacentTilesCoordForTileCoord:(CGPoint)tileCoord;


@end
