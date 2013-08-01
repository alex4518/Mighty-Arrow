//
//  SoundMenu.m
//  Mighty Sword
//
//  Created by alex on 01/08/2013.
//  Copyright (c) 2013 alex. All rights reserved.
//

#import "SoundMenu.h"
#import "SimpleAudioEngine.h"
#import "MainMenuLayer.h"

@implementation SoundMenu

+(id) scene
{
    
    CCMenuItem *sound, *back;

    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    CCScene *scene = [CCScene node];
    
    SoundMenu *layer = [SoundMenu node];
    
    [scene addChild: layer];
    
    CCLayer *menuLayer = [[CCLayer alloc] init];
    [scene addChild:menuLayer];
    
    
    if ([CDAudioManager sharedManager].mute == FALSE) {
 
    sound = [CCMenuItemFont itemWithString:@"Sound Off" target:layer selector:@selector(soundToggle:)];
    }
    else {
        sound = [CCMenuItemFont itemWithString:@"Sound On"target:layer selector:@selector(soundToggle:)];
    }
    
    back = [CCMenuItemFont itemWithString:@"Back"target:layer selector:@selector(back:)];
    
    CCMenu *menu = [CCMenu menuWithItems: sound, back, nil];
    [menuLayer addChild: menu];
    
    menu.position = ccp(winSize.width/2 , winSize.height/2);
    [menu alignItemsVerticallyWithPadding:15];
    
    return scene;
}

- (void) soundToggle : (id) sender {
    if ([CDAudioManager sharedManager].mute == TRUE) {
        
        [CDAudioManager sharedManager].mute = FALSE;
    }
    else {
        [CDAudioManager sharedManager].mute = TRUE;
    }
    
    [[CCDirector sharedDirector] replaceScene:[SoundMenu scene]];
}

- (void) back : (id) sender {
    
    [[CCDirector sharedDirector] replaceScene:[MainMenuLayer scene]];
}

-(id) init
{
    
    if( (self=[super initWithColor:ccc4(0, 0, 0, 0)])) {
        
    }
    return self;
}

@end
