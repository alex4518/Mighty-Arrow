//
//  GameOver.m
//  Mighty Sword
//
//  Created by alex on 18/07/2013.
//  Copyright (c) 2013 alex. All rights reserved.
//

#import "GameOverLayer.h"
#import "GameLayer.h"

@implementation GameOverLayer

+(CCScene *) scene {
    CCScene *scene = [CCScene node];
    GameOverLayer *layer = [[GameOverLayer alloc] init];
    [scene addChild: layer];
    return scene;
}

- (id)init {
    if ((self = [super initWithColor:ccc4(0, 0, 0, 0)])) {
        
        NSString * message;
        
        message = @"Game Over!";
     
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CCLabelTTF * label = [CCLabelTTF labelWithString:message fontName:@"Arial" fontSize:32];
        label.color = ccc3(255,255,255);
        label.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:label];
        
        [self runAction:
         [CCSequence actions:
          [CCDelayTime actionWithDuration:3],
          [CCCallBlockN actionWithBlock:^(CCNode *node) {
          [[CCDirector sharedDirector] replaceScene:[GameLayer scene]];}],
          [CCCallBlockN actionWithBlock:^(CCNode *node) {
          [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                                                           transitionWithDuration:1
                                                     scene:[MainMenuLayer scene]]];}],
          nil]];
    }
    return self;
}

@end
