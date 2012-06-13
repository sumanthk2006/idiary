//
//  Page_Alice_Example5.m
//  iDiary2
//
//  Created by Markus Konrad on 13.06.12.
//  Copyright (c) 2012 INKA Forschungsgruppe. All rights reserved.
//

#import "Page_Alice_Example5.h"

#import "Makros.h"

@interface Page_Alice_Example5(PrivateMethods)

-(void)playerCrashed;

@end

@implementation Page_Alice_Example5

-(id)init {
    self = [super init];
    
    if (self) {
        // sounds
        [self addBackgroundSound:@"wind1.mp3" looped:YES startTime:0.25f];
        crashSndId = [self addFxSound:@"thunder1.mp3"];
    
        // create the game
        game = [[ScrollingRaceGame alloc] initOnPageLayer:self inRect:CGRectMake(60, 100, 1024 - 120, 768 - 100) obstaclesPerSecond:0.75f goodBadRatio:0.75f];
        
        // set the offset for the spawning of the obstacles
        [game setSpawnOffset:ccp(0, -300.0f)];
        
        // set callback for crash
        [game setCrashCallbackObj:self];
        [game setCrashCallbackMethod:@selector(playerCrashed)];
        
        // set game controls
        [game setControlsForLeft:@"alice_example5__button_li.png" pos:ccp(427, 85) andRight:@"alice_example5__button_re.png" pos:ccp(584, 87)];
        
        // set racer
        [game setRacer:@"alice_example5__player.png" pos:ccp(484, 389)];        // taken from http://en.opensuse.org/index.php?title=File:Icon-package.png&filetimestamp=20100615144104
        [game setRacerTail:@"alice_example5__playertail.png" offsetToRacer:ccp(57, 60)];
        
        // set obstacles: "good" (non-crashing) and "bad" ones
        [game setObstacle:@"alice_example5__wolke1.png" good:YES minScale:0.5f maxScale:1.2f];
        [game setObstacle:@"alice_example5__wolke2.png" good:YES minScale:0.5f maxScale:1.2f];
        [game setObstacle:@"alice_example5__wolke3.png" good:YES minScale:0.5f maxScale:1.2f];
        [game setObstacle:@"alice_example5__gewitter.png" good:NO minScale:0.5f maxScale:1.0f];    // iz bad!
        
        [self addChild:game z:1];
    }
    
    return self;
}

-(void)dealloc {
    [game release];

    [super dealloc];
}

#pragma mark parent methods

- (void)loadPageContents {
    // set individual properties
    pageBackgroundImg = @"alice_seiten_hintergrund.png";
    
    // text
    MediaDefinition *mDefWelcomeText = [MediaDefinition mediaDefinitionWithText:@"This page shows how to use the ScrollingRaceGame class."
                                                                           font:@"Courier New"
                                                                       fontSize:18
                                                                          color:ccBLACK
                                                                         inRect:CGRectMake(60, 700, 350, 100)];
    
    [mediaObjects addObject:mDefWelcomeText];
    
    // start game
    [game performSelector:@selector(startGame) withObject:nil afterDelay:0.25f];
    
    // common media objects will be loaded in the PageLayer
    [super loadPageContents];

}

#pragma mark private methods

-(void)playerCrashed {
    NSLog(@"Player crashed!");
    
    [[sndHandler getSound:crashSndId] playAtPitch:RAND_MIN_MAX(0.75f, 1.25f)];
}



@end
