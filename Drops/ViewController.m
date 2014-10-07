//
//  ViewController.m
//  Drops
//
//  Created by namsk on 13. 7. 4..
//  Copyright (c) 2013년 namsk. All rights reserved.
//

#import "ViewController.h"
#import "DropsScene.h"

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;

    NSLog(@"%f x %f", skView.frame.size.width, skView.frame.size.height);
    SKScene *scene = [DropsScene sceneWithSize:CGSizeMake(skView.frame.size.width, skView.frame.size.height)];
    [skView presentScene:scene];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeLeft;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        return UIInterfaceOrientationMaskAllButUpsideDown;
        return UIInterfaceOrientationMaskLandscape;
    } else {
//        return UIInterfaceOrientationMaskAll;
        return UIInterfaceOrientationMaskLandscape;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}
@end
