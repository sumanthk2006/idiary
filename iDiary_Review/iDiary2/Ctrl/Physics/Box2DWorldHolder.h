//
//  Box2DWorldHolder.h
//  iDiary2
//
//  Created by Markus Konrad on 02.05.11.
//  Copyright 2011 INKA Forschungsgruppe. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "cocos2d.h"
#import "GLES-Render.h"
#import "Constants.h"
#import "Singleton.h"

typedef enum {
    kB2dWorldTypeTable = 0,
    kB2dWorldTypeDefault,
    kB2dWorldTypeBoxing,
    kB2dWorldTypeNoBorders,
} b2dWorldType;

typedef struct {
    float gravity;
    BOOL fixedGravity;
    b2World *world;
    b2dWorldType worldType;
    GLESDebugDraw *dbgDraw;
} b2dWorldAttributes;

@protocol PhysicsNotificationDelegate <NSObject>

-(void)willUpdateNode:(CCNode *)node withNewPosition:(CGPoint *)posValue;

@end

@interface Box2DWorldHolder : NSObject<Singleton> {
    NSMutableDictionary *worlds;    // NSNumber kB2dWorldType to NSValue->b2dWorldAttributes pointer mapping
    
    id<PhysicsNotificationDelegate> delegate;
}

@property (nonatomic,assign) id<PhysicsNotificationDelegate> delegate;

// returns the b2dWorldAttributes struct with all information about a box2d world
-(b2dWorldAttributes *)worldAttribsForType:(b2dWorldType)worldType;

// remove a world from memory
-(void)destroyWorldOfType:(b2dWorldType)worldType;

// draws complete debug data for a world
-(void)drawDebugViewForType:(b2dWorldType)worldType;
-(void)drawDebugViewForAttributes:(b2dWorldAttributes *)w;

// updates the worlds state and synchronizes the physical bodies with the cocos2D sprites
-(void)updateWorldForType:(b2dWorldType)worldType withDeltaTime:(ccTime)dt;
-(void)updateWorldForAttributes:(b2dWorldAttributes *)w withDeltaTime:(ccTime)dt;

// updates the gravity vector for a world
-(void)updateGravityForType:(b2dWorldType)worldType withX:(float)x andY:(float)y;
-(void)updateGravityForAttributes:(b2dWorldAttributes *)w withX:(float)x andY:(float)y;

@end
