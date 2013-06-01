//
//  HelloWorldLayer.m
//  cocos
//
//  Created by alex on 06/03/2013.
//  Copyright alex 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"
#import "InputLayer.h"


#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation

@implementation HelloWorldLayer

@synthesize bgLayer = _bgLayer,themap =_themap;

static HelloWorldLayer* sharedGameLayer;
+(HelloWorldLayer*) sharedGameLayer
{
	NSAssert(sharedGameLayer != nil, @"GameScene instance not yet initialized!");
	return sharedGameLayer;
}

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
    // 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
    
    InputLayer* inputLayer=[InputLayer node];
    [scene addChild:inputLayer z:1];
    


	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
    
    sharedGameLayer = self;
    
    CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    [frameCache addSpriteFramesWithFile:@"hero.plist"];

	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		
        self.themap = [CCTMXTiledMap tiledMapWithTMXFile:@"map.tmx"];
        self.bgLayer = [_themap layerNamed:@"bg"];
        [self addChild:_themap z:-1];
        
    }
    
    Hero* hero = [Hero hero];
    hero.tag = 1;

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    [hero setPosition:ccp(screenHeight/2 , screenWidth/2)];
    [self addChild:hero];
   
 
    
    return self;

}

-(Hero*) defaultHero
{
	CCNode* node = [self getChildByTag:1];
	NSAssert([node isKindOfClass:[Hero class]], @"node is not a Ship!");
	return (Hero*)node;
}

// on "dealloc" you need to release all your retained objects

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
