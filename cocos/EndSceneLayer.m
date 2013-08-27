//
//  EndSceneLayer.m
//  Mighty_Arrow
//
//  Created by alex on 27/08/2013.
//  Copyright (c) 2013 alex. All rights reserved.
//

#import "EndSceneLayer.h"
#import "MainMenuLayer.h"

@implementation EndSceneLayer

+(id) scene{
    
    CCScene *scene=[CCScene node];
    
    EndSceneLayer* layer = [EndSceneLayer node];
    
    [scene addChild:layer];
    
    return scene;
}

-(id)init {
    
    if( (self=[super init] )) {
        
        CGSize winSize = [CCDirector sharedDirector].winSize;

        
        CCSprite* hero = [CCSprite spriteWithFile:@"hero-front.png"];
        CCSprite* princess = [CCSprite spriteWithFile:@"isabella-front.png"];
        
        hero.scale = 2;
        princess.scale = 3;
        
        hero.position = ccp(winSize.width * 0.1, winSize.height * 0.3);
        princess.position = ccp(winSize.width * 0.9, winSize.height * 0.3);
        
        [self addChild:hero];
        [self addChild:princess];
        
        NSString* string = [NSString stringWithFormat:@"%@\r%@",@"Thank you Sir Gregory", @"Our Kingdom is safe again"];
        
        CCLabelTTF*label = [CCLabelTTF labelWithString:string fontName:@"Courier New" fontSize:20];
        
        label.position = ccp(winSize.width/2, winSize.height * 0.7);
        
        [self addChild:label];
        
    }
    
    return self;
}

-(void) onEnter
{
	[super onEnter];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:6.0 scene:[MainMenuLayer scene] ]];
}

@end
