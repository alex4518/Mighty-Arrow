//
//  GameLayer.m
//  cocos
//
//  Created by alex on 06/03/2013.
//  Copyright alex 2013. All rights reserved.
//


// Import the interfaces
#import "GameLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"
#import "InputLayer.h"
#import "PauseScene.h"
#import "SimpleAudioEngine.h"


#pragma mark - GameLayer

// GameLayer implementation

@implementation GameLayer


static GameLayer* sharedGameLayer;
+(GameLayer*) sharedGameLayer
{
	NSAssert(sharedGameLayer != nil, @"GameScene instance not yet initialized!");
	return sharedGameLayer;
}

// Helper class method that creates a Scene with the GameLayer as the only child.
+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
    
    HUDLayer *hud = [HUDLayer node];
    
    GameLayer *layer = [[GameLayer alloc] initWithHUD:hud];
	
	// add layer as a child to scene
	[scene addChild: layer];
    
	// return the scene
	return scene;
}

-(void) pause: (id) sender{
    [[CCDirector sharedDirector] pushScene:[PauseScene node]];
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        
        sharedGameLayer = self;

        
        CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [frameCache addSpriteFramesWithFile:@"chars.plist"];
		
    }
    
    Hero* hero = [Hero hero];
    hero.tag = 1;

    [hero setPosition:ccp(100 , 100)];
    [self addChild:hero];
    
    
    [self scheduleUpdate];
    
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    
    return self;

}

- (id)initWithHUD:(HUDLayer *)hud
{
    if ((self = [self init])) {
        _hud = hud;
        // Rest of method...
    }
    return self;
}

-(Hero*) defaultHero
{
	CCNode* node = [self getChildByTag:1];
	NSAssert([node isKindOfClass:[Hero class]], @"node is not a Hero!");
	return (Hero*)node;
}

- (CGPoint)tileCoordForPosition:(CGPoint)position {
    int x = position.x*2 / _themap.tileSize.width;
    int y = ((_themap.mapSize.height * _themap.tileSize.height) - (position.y*2)) / _themap.tileSize.height;
    return ccp(x, y);
}

- (CGPoint)positionForTileCoord:(CGPoint)tileCoord {
    int x = ((tileCoord.x) * _themap.tileSize.width) + _themap.tileSize.width/2;
    int y = (_themap.mapSize.height * _themap.tileSize.height) - (tileCoord.y * _themap.tileSize.height) - _themap.tileSize.height/2;
    return ccp(x/2, y/2);
}

- (BOOL)isValidTileCoord:(CGPoint)tileCoord {
    if (tileCoord.x < 0 || tileCoord.y < 0 ||
        tileCoord.x >= _themap.mapSize.width ||
        tileCoord.y >= _themap.mapSize.height) {
        return FALSE;
    } else {
        return TRUE;
    }
}

-(BOOL)isProp:(NSString*)prop atTileCoord:(CGPoint)tileCoord forLayer:(CCTMXLayer *)layer {
    if (![self isValidTileCoord:tileCoord]) return NO;
    int gid = [layer tileGIDAt:tileCoord];
    NSDictionary * properties = [_themap propertiesForGID:gid];
    if (properties == nil) return NO;
    return [properties objectForKey:prop] != nil;
}

-(BOOL)isBlockedAtTileCoord:(CGPoint)tileCoord {
    return [self isProp:@"Blocked" atTileCoord:tileCoord forLayer:_metaLayer];
}

- (NSArray *)walkableAdjacentTilesCoordForTileCoord:(CGPoint)tileCoord
{
	NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:4];
    
	// Top
	CGPoint p = CGPointMake(tileCoord.x, tileCoord.y - 1);
	if ([self isValidTileCoord:p]  && ![self isBlockedAtTileCoord:p]) {
		[tmp addObject:[NSValue valueWithCGPoint:p]];
	}
    
	// Left
	p = CGPointMake(tileCoord.x - 1, tileCoord.y);
	if ([self isValidTileCoord:p]  && ![self isBlockedAtTileCoord:p]) {
		[tmp addObject:[NSValue valueWithCGPoint:p]];
	}
    
	// Bottom
	p = CGPointMake(tileCoord.x, tileCoord.y + 1);
	if ([self isValidTileCoord:p]  && ![self isBlockedAtTileCoord:p]) {
		[tmp addObject:[NSValue valueWithCGPoint:p]];
	}
    
	// Right
	p = CGPointMake(tileCoord.x + 1, tileCoord.y);
	if ([self isValidTileCoord:p] && ![self isBlockedAtTileCoord:p]) {
		[tmp addObject:[NSValue valueWithCGPoint:p]];
	}
    
	return [NSArray arrayWithArray:tmp];
}
@end
