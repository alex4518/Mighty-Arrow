//
//  Hero.m
//  cocos
//
//  Created by alex on 04/06/2013.
//  Copyright 2013 alex. All rights reserved.
//

#import "Hero.h"
#import "GameLayer.h"
#import "InputLayer.h"
#import "Level1.h"
#import "Level2.h"
#import "Level3.h"
#import "Level4.h"
#import "MainMenuLayer.h"
#import "SimpleAudioEngine.h"



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
    self.level = kHeroInitialLevel;
    self.currentXP = kHeroInitialXp;
    self.heroHealth = kHeroHealth;
    self.heroDamageFromLevelUp = 0;
    self.canShoot = YES;
    
    
	// Loading the Hero's sprite using a sprite frame name (eg the filename)
	if ((self = [super initWithSpriteFrameName:@"right.png"]))
	{        
        [self initAnimations];
        [self scheduleUpdate];

	}
	return self;
}

-(int) getDamage {
    
    return kHeroInitialDamage + self.heroDamageFromLevelUp;
}

-(void) recieveXP:(int)xpPoints {
    if (self.currentXP + xpPoints < 100) {
        self.currentXP += xpPoints;
    } else {
        self.currentXP += xpPoints - 100;
        _level++;
        self.heroDamageFromLevelUp = self.heroDamageFromLevelUp + 5;
    }
}

-(CGRect) heroBoundingBox {
   
    CGRect absoluteBox = CGRectMake(self.position.x, self.position.y, [self boundingBox].size.width, [self boundingBox].size.height);
    
    return absoluteBox;
}

-(CGRect) arrowBoundingBox {
    
    return self.arrow.boundingBox;
}

-(void) update:(ccTime)delta {
    
    GameLayer* game = [GameLayer sharedGameLayer];
    
    float mapWidth = (game.themap.mapSize.width * game.themap.tileSize.width)/2;
    float mapHeight = (game.themap.mapSize.height * game.themap.tileSize.height)/2;
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    int x = MAX(self.position.x, winSize.width/2);
    int y = MAX(self.position.y, winSize.height/2);
    x = MIN(x, mapWidth - winSize.width / 2);
    y = MIN(y, mapHeight - winSize.height/2);
    CGPoint actualPosition = ccp(x, y);
    
    CGPoint centerOfView = ccp(winSize.width/2, winSize.height/2);
    CGPoint viewPoint = ccpSub(centerOfView, actualPosition);
    game.position = viewPoint;
    
    
    // Make sure player doesn't walk out of the screen
    if (self.position.x < 24.0f) {
        self.position = ccp(24.0f, self.position.y);
    } else if (self.position.x > (game.themap.mapSize.width * game.themap.tileSize.width)/2 - 24.0f) {
        self.position = ccp(mapWidth - 24.0f, self.position.y);
    } else if (self.position.y < 36.0f) {
        self.position = ccp(self.position.x, 36.0f);
    } else if (self.position.y > (game.themap.mapSize.height * game.themap.tileSize.height)/2 - 24.0f) {
        self.position = ccp(self.position.x, mapWidth - 24.0f);
    }
    
    [self applyJoystick:self.joystick
           forTimeDelta:delta];
}


-(void)applyJoystick:(SneakyJoystick *)aJoystick forTimeDelta:(float)delta {
    
    
    GameLayer* game = [GameLayer sharedGameLayer];

    
    CGPoint velocity = ccpMult(aJoystick.velocity, 2000 * delta);
    
    CGPoint position = CGPointMake(self.position.x + velocity.x * delta, self.position.y + velocity.y * delta);
    CGPoint tileCoord = [game tileCoordForPosition:position];
    int tileGid = [game.metaLayer tileGIDAt:tileCoord];
    if (tileGid) {
        NSDictionary *properties = [game.themap propertiesForGID:tileGid];
        if (properties) {
            NSString *collision = properties[@"Blocked"];
            if (collision && [collision isEqualToString:@"1"]) {
        
                [[SimpleAudioEngine sharedEngine]playEffect:@"hitWall.wav"];

                return;
            }
        }
    }
    
    self.position = CGPointMake(self.position.x + velocity.x * delta, self.position.y + velocity.y * delta);

    
    if (aJoystick.velocity.x == 1.0f) {
        
        [self stopAction:self.walkUpAction];
        [self stopAction:self.walkDownAction];
        [self stopAction:self.walkLeftAction];
        
        myDirection = DirectionRight;
        
        if (self.numberOfRunningActions == 0) {
            [self runAction:self.walkRightAction];
          
          [[SimpleAudioEngine sharedEngine] stopEffect:self.soundEffectID];
          self.soundEffectID = [[SimpleAudioEngine sharedEngine] playEffect:@"Walking.mp3"];
        }
    }
    else if (aJoystick.velocity.x == -1.0f){
        
        [self stopAction:self.walkUpAction];
        [self stopAction:self.walkDownAction];
        [self stopAction:self.walkRightAction];
        
        myDirection = DirectionLeft;

        
        if (self.numberOfRunningActions == 0) {
            [self runAction:self.walkLeftAction];
            
            [[SimpleAudioEngine sharedEngine] stopEffect:self.soundEffectID];
            self.soundEffectID = [[SimpleAudioEngine sharedEngine] playEffect:@"Walking.mp3"];
        }
    }
    else if (aJoystick.velocity.y == 1.0f){
        
        [self stopAction:self.walkDownAction];
        [self stopAction:self.walkLeftAction];
        [self stopAction:self.walkRightAction];
        
        myDirection = DirectionUp;

        
        if (self.numberOfRunningActions == 0) {
            [self runAction:self.walkUpAction];
            
            [[SimpleAudioEngine sharedEngine] stopEffect:self.soundEffectID];
            self.soundEffectID = [[SimpleAudioEngine sharedEngine] playEffect:@"Walking.mp3"];
        }
    }
    else if (aJoystick.velocity.y == -1.0f){
        
        [self stopAction:self.walkUpAction];
        [self stopAction:self.walkLeftAction];
        [self stopAction:self.walkRightAction];
        
        myDirection = DirectionDown;

        
        if (self.numberOfRunningActions == 0) {
            [self runAction:self.walkDownAction];
            
            [[SimpleAudioEngine sharedEngine] stopEffect:self.soundEffectID];
            self.soundEffectID = [[SimpleAudioEngine sharedEngine] playEffect:@"Walking.mp3"];
        }
    }
    else if (self.attackButton.active == YES) {
        
      
        [self stopAllActions];
        
    if (self.numberOfRunningActions == 0 && self.arrow.numberOfRunningActions ==0) {
            
            
        [self shoot];
            
        }
    }
        
    else {
        [self stopAllActions];
        
        [[SimpleAudioEngine sharedEngine] stopEffect:self.soundEffectID];
    }
}

- (void)shoot {
    
    GameLayer* game = [GameLayer sharedGameLayer];
    
    
    switch (myDirection) {
        case DirectionRight:
            realX = (game.themap.mapSize.width * game.themap.tileSize.width)/2;
            realY = self.position.y;
            
            self.arrow = [CCSprite spriteWithFile:@"arrow-right.png"];
            break;
            
        case DirectionLeft:
            realX = 0;
            realY = self.position.y;
            
            self.arrow = [CCSprite spriteWithFile:@"arrow-left.png"];
            break;
            
        case DirectionUp:
            realX = self.position.x;
            realY = (game.themap.mapSize.height * game.themap.tileSize.height)/2;
            
            self.arrow = [CCSprite spriteWithFile:@"arrow-up.png"];
            break;
            
        case DirectionDown:
            realX = self.position.x;
            realY = 0;
            
            self.arrow = [CCSprite spriteWithFile:@"arrow-down.png"];
            break;
            
        default:
            break;
    }
    
    // While hero is not taking damage he can launch arrows
    if (self.canShoot) {
    
    self.arrow.position = self.position;
        
    [game addChild:self.arrow];
        
    [[SimpleAudioEngine sharedEngine] playEffect:@"Warfare Arrow.mp3"];
    CGPoint realDest = ccp(realX, realY);
    
    // Determine the length of how far you're shooting
    int offRealX = realX - self.arrow.position.x;
    int offRealY = realY - self.arrow.position.y;
    float length = sqrtf((offRealX*offRealX)+(offRealY*offRealY));
    float velocity = 480/1; // 480pixels/1sec
    float realMoveDuration = length/velocity;
    
    
    // Move arrow to actual endpoint
    [self.arrow runAction:
     [CCSequence actions:
      [CCMoveTo actionWithDuration:realMoveDuration position:realDest],
      [CCCallBlockN actionWithBlock:^(CCNode *node) {
   
         [node removeFromParentAndCleanup:YES];
         
     }],
      nil]];
    }
}

-(void)initAnimations {
    
    //move right animation
    
    NSMutableArray *walkRightAnimFrames = [NSMutableArray array];
    
    [walkRightAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"right_left_step.png"]]];
    
    [walkRightAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"right.png"]]];
    
    
    [walkRightAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"right_right_step.png"]]];
    
    CCAnimation *walkRightAnim = [CCAnimation animationWithSpriteFrames:walkRightAnimFrames delay:0.2f];
    
    self.walkRightAction = [CCRepeatForever actionWithAction:
                                    [CCAnimate actionWithAnimation:walkRightAnim]];
    
    
    //move left animation
    
    NSMutableArray *walkLeftAnimFrames = [NSMutableArray array];
    
    [walkLeftAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"left_left_step.png"]]];
    
    [walkLeftAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"left.png"]]];
    
    [walkLeftAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"left_right_step.png"]]];
    
    CCAnimation *walkLeftAnim = [CCAnimation animationWithSpriteFrames:walkLeftAnimFrames delay:0.2f];
    
    self.walkLeftAction = [CCRepeatForever actionWithAction:
                           [CCAnimate actionWithAnimation:walkLeftAnim]];
    
    
    
    
    //move up animation
    
    NSMutableArray *walkUpAnimFrames = [NSMutableArray array];
    
    [walkUpAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"back_left_step.png"]]];
    
    [walkUpAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"back_right_step.png"]]];
    
    CCAnimation *walkUpAnim = [CCAnimation animationWithSpriteFrames:walkUpAnimFrames delay:0.3f];
    
    self.walkUpAction = [CCRepeatForever actionWithAction:
                         [CCAnimate actionWithAnimation:walkUpAnim]];
    
    
    //move down animation
    
    NSMutableArray *walkDownAnimFrames = [NSMutableArray array];
    
    [walkDownAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"front_left_step.png"]]];
    
    [walkDownAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"front_right_step.png"]]];
    
    CCAnimation *walkDownAnim = [CCAnimation animationWithSpriteFrames:walkDownAnimFrames delay:0.3f];
    
    self.walkDownAction = [CCRepeatForever actionWithAction:
                           [CCAnimate actionWithAnimation:walkDownAnim]];


}
@end
