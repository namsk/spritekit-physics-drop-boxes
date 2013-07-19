//
//  DropsScene.m
//  Drops
//
//  Created by namsk on 13. 7. 4..
//  Copyright (c) 2013년 namsk. All rights reserved.
//

#import "DropsScene.h"

static const uint32_t floorCategory = 0x1 << 0;
static const uint32_t boxCategory   = 0x1 << 1;

@implementation DropsScene
- (id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        NSLog(@"%f x %f", self.frame.size.width, self.frame.size.height);
        
        //  Set background
        self.backgroundColor = [SKColor grayColor];
        self.physicsWorld.contactDelegate = self;
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        
        //  Draw floor and set physics properties
        SKSpriteNode *floor = [self createFloor];
        [floor setName:@"floor"];
        [self addChild:floor];
        
        [floor setPosition:CGPointZero];

        floor.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:floor.frame];
        floor.physicsBody.dynamic = NO;
        floor.physicsBody.categoryBitMask = floorCategory;
        floor.physicsBody.contactTestBitMask = boxCategory;
        floor.physicsBody.collisionBitMask = boxCategory;
    }
    return self;
}

- (SKSpriteNode *)createFloor {
    SKSpriteNode *floor = [SKSpriteNode spriteNodeWithColor:[SKColor brownColor]
                                                       size:CGSizeMake(CGRectGetWidth(self.frame), 20)];
    [floor setAnchorPoint:CGPointZero];
    return floor;
}

- (SKSpriteNode *)createBox:(CGPoint)location {
    SKSpriteNode *box = [[SKSpriteNode alloc]initWithColor:[SKColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1.0]
                                                      size:CGSizeMake(40, 40)];
    
    box.position = location;
    box.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(40, 40)];
    box.name = @"ball";
    box.physicsBody.dynamic = YES;
    //        ball.physicsBody.usesPreciseCollisionDetection = YES;   // YES if object is small and fast
    
    box.physicsBody.categoryBitMask = boxCategory;
    box.physicsBody.collisionBitMask = floorCategory | boxCategory ;
    box.physicsBody.contactTestBitMask = floorCategory | boxCategory ;
    //  It creates SKPhysicsContact object internally.
    
    //        Important properties of PhysicsBody
    //        ball.physicsBody.mass = 0;    //  mass of physics object
    //        ball.physicsBody.density = 0;     //  density of physics object: defaul 1.0
    //        ball.physicsBody.friction = 0;    //  friction of physics object: 0.0 ~ 1.0
    //        ball.physicsBody.restitution = 0; //  restitution(bounciness) of physics object: 0.0 ~ 1.0 : default 0.2
    return box;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        [self addChild:[self createBox:location]];
    }
}

#pragma mark - SpriteKit Lifecycle (Each Frame)
//  Sprite Kit Programming Guide
//  Each Frame:
//      - update
//      - SKScene evaluates actions
//      - didEvaluateActions
//      - SKScene simulate physics
//      - didSimulatePhysics
- (void)update:(NSTimeInterval)currentTime {
    
}

- (void)didEvaluateActions {
    
}

- (void)didSimulatePhysics {
    [self enumerateChildNodesWithName:@"ball" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.y < 0) {
            NSLog(@"node removed");
            [node removeFromParent];
        }
    }];
}

#pragma mark - SKPhysicsContactDelegate Implementation
//  physicsWorld.contactTestBitmask of SKSprite should be set.
- (void)didBeginContact:(SKPhysicsContact *)contact {
    NSLog(@"[Contact! Begin] %@ and %@", contact.bodyA.node.name, contact.bodyB.node.name);
}

- (void)didEndContact:(SKPhysicsContact *)contact {
    NSLog(@"[Contact! End] %@ and %@", contact.bodyA.node.name, contact.bodyB.node.name);
}
@end
