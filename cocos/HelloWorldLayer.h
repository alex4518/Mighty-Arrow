//
//  HelloWorldLayer.h
//  cocos
//
//  Created by alex on 06/03/2013.
//  Copyright alex 2013. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "SneakyJoystick.h" 
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "SneakyJoystickSkinnedBase.h"
#import "Hero.h"



// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    CCTMXTiledMap *themap ;
    CCTMXLayer *bgLayer ;
}

@property(nonatomic,strong) CCTMXTiledMap *themap;
@property(nonatomic,strong) CCTMXLayer *bgLayer ;

-(Hero*) defaultHero;

+(HelloWorldLayer*) sharedGameLayer;



// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
