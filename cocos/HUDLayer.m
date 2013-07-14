//
//  HUDLayer.m
//  Mighty Sword
//
//  Created by Panos Albanis on 14/07/2013.
//  Copyright (c) 2013 alex. All rights reserved.
//

#import "HUDLayer.h"

@implementation HUDLayer

- (id)init {
    
    if ((self = [super init])) {
        
        CGSize winSize = [CCDirector sharedDirector].winSize;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            _statusLabel = [CCLabelTTF labelWithString:@"" fontName:@"arial-hd" fontSize:24];
        } else {
            _statusLabel = [CCLabelTTF labelWithString:@"" fontName:@"arial" fontSize:24];
        }
        _statusLabel.position = ccp(winSize.width* 0.85, winSize.height * 0.9);
        [self addChild:_statusLabel];
    }
    return self;
}

- (void)setStatusString:(NSString *)string {
    _statusLabel.string = string;
}

@end
