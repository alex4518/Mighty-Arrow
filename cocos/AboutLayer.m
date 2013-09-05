//
//  AboutLayer.m
//  Mighty_Arrow
//
//  Created by Alexandros Almpanis on 26/08/2013.
//  Copyright (c) 2013 alex. All rights reserved.
//

#import "AboutLayer.h"
#import "MainMenuLayer.h"

@implementation AboutLayer

+(id) scene{
    
    CCScene *scene=[CCScene node];
    
    AboutLayer* layer = [AboutLayer node];
    
    [scene addChild:layer];
    
    return scene;
}

-(id)init {
    
    if( (self=[super init] )) {
        
        
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        NSString* title = @"Mighty Arrow v1.0"; 
        NSString* created = @"Created By: Alexandros Almpanis";
        NSString* credits = @"Credits";
        NSString* sprites = [NSString stringWithFormat:@"%@\r%@\r%@\r%@", @"Sprites From:",@" www.mmorpgmakerxb.com", @"wiki.themanaworld.org", @"http://forums.themanaworld.org"];
        NSString*music = [NSString stringWithFormat:@"%@\r%@", @"Music From:", @"Celestial Aeon http://celestialaeonproject.jamendo.net"];
        NSString* effects = [NSString stringWithFormat:@"%@\r%@\r%@", @"Sound Effects From:", @"SoundBible.com", @"http://www.soundboard.com"];
        
    
        CCLabelTTF* label1 = [CCLabelTTF labelWithString:title fontName:@"Courier New" fontSize:24];
        label1.position = ccp(winSize.width/2, winSize.height-50);
        
        CCLabelTTF* label2 = [CCLabelTTF labelWithString:created fontName:@"Courier New" fontSize:12];
        label2.position = ccp(winSize.width/2, winSize.height-80);
        
        CCLabelTTF* label3 = [CCLabelTTF labelWithString:credits fontName:@"Courier New" fontSize:18];
        label3.position = ccp(winSize.width/2, winSize.height-115);
        
        CCLabelTTF* label4 = [CCLabelTTF labelWithString:sprites fontName:@"Courier New" fontSize:12];
        label4.position = ccp(winSize.width/2, winSize.height-170);
        
        CCLabelTTF* label5 = [CCLabelTTF labelWithString:music fontName:@"Courier New" fontSize:12];
        label5.position = ccp(winSize.width/2, winSize.height-230);
        
        CCLabelTTF* label6 = [CCLabelTTF labelWithString:effects fontName:@"Courier New" fontSize:12];
        label6.position = ccp(winSize.width/2, winSize.height-280);
        
        [self addChild:label1];
        [self addChild:label2];
        [self addChild:label3];
        [self addChild:label4];
        [self addChild:label5];
        [self addChild:label6];
        
       CCMenuItem* back = [CCMenuItemFont itemWithString:@"Back"target:self selector:@selector(back:)];
        
        CCMenu *menu = [CCMenu menuWithItems:back, nil];
        menu.position = ccp(winSize.width-50,20);
        [self addChild: menu];

    }
    return self;
    
}

- (void) back : (id) sender {
    
    [[CCDirector sharedDirector] replaceScene:[MainMenuLayer scene]];
}

@end
