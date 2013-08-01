//
//  MyCocos2DClass.m
//  Mighty Sword
//
//  Created by alex on 19/07/2013.
//  Copyright 2013 alex. All rights reserved.
//

#import "PauseScene.h"
#import "MainMenuLayer.h"
#import "SimpleAudioEngine.h"


@implementation PauseScene

+(id) scene{
    CCScene *scene=[CCScene node];
    
    PauseScene *layer = [PauseScene node];
    
    [scene addChild: layer];
    
    return scene;
}

-(id)init{
    if( (self=[super init] )) {
        
        
        CGSize winSize = [CCDirector sharedDirector].winSize;

        
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Paused"
                                               fontName:@"Courier New"
                                               fontSize:30];
        label.position = ccp(winSize.width/2,210);
        [self addChild: label];
        [CCMenuItemFont setFontName:@"Courier New"];
        [CCMenuItemFont setFontSize:20];
        
        CCMenuItem *Resume= [CCMenuItemFont itemWithString:@"Resume"
                                                    target:self
                                                  selector:@selector(resume:)];
        CCMenuItem *Quit = [CCMenuItemFont itemWithString:@"Quit Game"
                                                   target:self selector:@selector(GoToMainMenu:)];
        
        CCMenuItem *sound;
        
        if ([CDAudioManager sharedManager].mute == FALSE) {
            
            sound = [CCMenuItemFont itemWithString:@"Sound Off" target:self selector:@selector(soundToggle:)];
        }
        else {
            sound = [CCMenuItemFont itemWithString:@"Sound On"target:self selector:@selector(soundToggle:)];
        }

        
        CCMenu *menu= [CCMenu menuWithItems: Resume, Quit, sound, nil];
        menu.position = ccp(winSize.width/2, 131.67f);
        [menu alignItemsVerticallyWithPadding:12.5f];
        
        [self addChild:menu];
        
    }
    return self;
}

- (void) soundToggle : (id) sender {
    if ([CDAudioManager sharedManager].mute == TRUE) {
        
        [CDAudioManager sharedManager].mute = FALSE;
    }
    else {
        [CDAudioManager sharedManager].mute = TRUE;
    }
    
    [[CCDirector sharedDirector] replaceScene:[PauseScene node]];
}

-(void) resume: (id) sender {
    
    [[CCDirector sharedDirector] popScene];
}

-(void) GoToMainMenu: (id) sender {
    
    [[CCDirector sharedDirector] sendCleanupToScene];
    [[CCDirector sharedDirector] popScene];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade
                                               transitionWithDuration:1
                                               scene:[MainMenuLayer scene]]];
}


@end
