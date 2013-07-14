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
	// Loading the Hero's sprite using a sprite frame name (eg the filename)
	if ((self = [super initWithSpriteFrameName:@"right_sword.png"]))
	{        
        [self initAnimations];

        [self scheduleUpdate];
        
	}
	return self;
}

-(CGRect) heroBoundingBox {
   
    CGRect absoluteBox = CGRectMake(self.position.x, self.position.y, [self boundingBox].size.width, [self boundingBox].size.height);
    
    return absoluteBox;
}

-(void) update:(ccTime)delta {
    
    GameLayer* game = [GameLayer sharedGameLayer];
    
    
    [self applyJoystick:self.joystick
           forTimeDelta:delta];
    
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
    } else if (self.position.y > (game.themap.mapSize.height * game.themap.tileSize.height)/2) {
        self.position = ccp(self.position.x, mapWidth);
    }
}


-(void)applyJoystick:(SneakyJoystick *)aJoystick forTimeDelta:(float)delta {
    
    CGPoint velocity = ccpMult(aJoystick.velocity, 2000 * delta);
    
    self.position = CGPointMake(self.position.x + velocity.x * delta, self.position.y + velocity.y * delta);

    
    if (aJoystick.velocity.x == 1.0f) {
        
        [self stopAction:self.walkUpAction];
        [self stopAction:self.walkDownAction];
        [self stopAction:self.walkLeftAction];
        
        if (self.numberOfRunningActions == 0) {
            [self runAction:self.walkRightAction];
        }
    }
    else if (aJoystick.velocity.x == -1.0f){
        
        [self stopAction:self.walkUpAction];
        [self stopAction:self.walkDownAction];
        [self stopAction:self.walkRightAction];
        
        if (self.numberOfRunningActions == 0) {
            [self runAction:self.walkLeftAction];
        }
    }
    else if (aJoystick.velocity.y == 1.0f){
        
        [self stopAction:self.walkDownAction];
        [self stopAction:self.walkLeftAction];
        [self stopAction:self.walkRightAction];
        
        if (self.numberOfRunningActions == 0) {
            [self runAction:self.walkUpAction];
        }
    }
    else if (aJoystick.velocity.y == -1.0f){
        
        [self stopAction:self.walkUpAction];
        [self stopAction:self.walkLeftAction];
        [self stopAction:self.walkRightAction];
        
        if (self.numberOfRunningActions == 0) {
            [self runAction:self.walkDownAction];

        }
    }
    else if (self.attackButton.active == YES) {
        [self stopAllActions];
        
        if (self.numberOfRunningActions == 0) {
            
            [self shootRight];
        }
    }
        
    else {
        [self stopAllActions];
    }
    
}


- (void)shootRight {
    
    GameLayer* game = [GameLayer sharedGameLayer];

    CGSize winSize = [[CCDirector sharedDirector] winSize];

    
    // Choose one of the touches to work with
    CGPoint location = ccp(winSize.width, self.position.y);
    
    // Set up initial location of projectile
    CCSprite *projectile = [CCSprite spriteWithFile:@"arrow-right.png"];
    projectile.position = self.position;
    
    // Determine offset of location to projectile
    CGPoint offset = ccpSub(location, projectile.position);
    
    [game addChild:projectile];
    
    int realX = winSize.width + (projectile.contentSize.width/2);
    float ratio = (float) offset.y / (float) offset.x;
    int realY = (realX * ratio) + projectile.position.y;
    CGPoint realDest = ccp(realX, realY);
    
    // Determine the length of how far you're shooting
    int offRealX = realX - projectile.position.x;
    int offRealY = realY - projectile.position.y;
    float length = sqrtf((offRealX*offRealX)+(offRealY*offRealY));
    float velocity = 480/1; // 480pixels/1sec
    float realMoveDuration = length/velocity;
    
    // Move projectile to actual endpoint
    [projectile runAction:
     [CCSequence actions:
      [CCMoveTo actionWithDuration:realMoveDuration position:realDest],
      [CCCallBlockN actionWithBlock:^(CCNode *node) {
         [node removeFromParentAndCleanup:YES];
     }],
      nil]];
    
}

-(void)initAnimations {
    
    //move right animation
    
    NSMutableArray *walkRightAnimFrames = [NSMutableArray array];
    
    [walkRightAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"right_left_step_sword.png"]]];
    
    [walkRightAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"right_sword.png"]]];
    
    
    [walkRightAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"right_right_step_sword.png"]]];
    
    CCAnimation *walkRightAnim = [CCAnimation animationWithSpriteFrames:walkRightAnimFrames delay:0.2f];
    
    self.walkRightAction = [CCRepeatForever actionWithAction:
                                    [CCAnimate actionWithAnimation:walkRightAnim]];
    
    
    //move left animation
    
    NSMutableArray *walkLeftAnimFrames = [NSMutableArray array];
    
    [walkLeftAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"left_left_step_sword.png"]]];
    
    [walkLeftAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"left_sword.png"]]];
    
    [walkLeftAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"left_right_step_sword.png"]]];
    
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
      [NSString stringWithFormat:@"front_left_step_sword.png"]]];
    
    [walkDownAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"front_right_step_sword.png"]]];
    
    CCAnimation *walkDownAnim = [CCAnimation animationWithSpriteFrames:walkDownAnimFrames delay:0.3f];
    
    self.walkDownAction = [CCRepeatForever actionWithAction:
                           [CCAnimate actionWithAnimation:walkDownAnim]];



    NSMutableArray *frontAttackAnimFrames = [NSMutableArray array];

    [frontAttackAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
  [NSString stringWithFormat:@"front_sword.png"]]];
    
    [frontAttackAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"front-attack2.png"]]];

    [frontAttackAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
      [NSString stringWithFormat:@"front-attack3.png"]]];

    CCAnimation *frontAttackAnim = [CCAnimation animationWithSpriteFrames:frontAttackAnimFrames delay:0.5f];

    self.frontAttackAction = [CCAnimate actionWithAnimation:frontAttackAnim];

}
@end
