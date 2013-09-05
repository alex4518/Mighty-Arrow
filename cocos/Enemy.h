//
//  Enemy.h
//  Mighty Sword
//
//  Created by Alexandros Almpanis on 04/06/2013.
//  Copyright 2013 alex. All rights reserved.
//

#import "ShortestPathStep.h"
#import "Hero.h"

@interface Enemy : CCSprite 
    

@property (nonatomic, retain) NSMutableArray *spOpenSteps;
@property (nonatomic, retain) NSMutableArray *spClosedSteps;
@property (nonatomic, retain) NSMutableArray *shortestPath;

@property (nonatomic, strong) CCAnimation *walkRightAnim;
@property (nonatomic, strong) CCAnimation *walkLeftAnim;
@property (nonatomic, strong) CCAnimation *walkUpAnim;
@property (nonatomic, strong) CCAnimation *walkDownAnim;

@property (nonatomic, readwrite) int health;

- (CGRect) enemyBoundingBox;
- (CGRect)eyesightBoundingBox;
- (void)initAnimations;
- (void)moveTowardHero;
- (void)insertInOpenSteps:(ShortestPathStep *)step;
- (int)computeHScoreFromCoord:(CGPoint)fromCoord toCoord:(CGPoint)toCoord;
- (int)costToMoveFromStep:(ShortestPathStep *)fromStep toAdjacentStep:(ShortestPathStep *)toStep;
- (void)constructPathAndStartAnimationFromStep:(ShortestPathStep *)step;
- (void)popStepAndAnimate;
- (int)getDamage;




@end

