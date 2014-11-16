//
//  YouhuiViewController.m
//  Ibeacon
//
//  Created by chenwg on 14-11-16.
//  Copyright (c) 2014年 chenwg.com. All rights reserved.
//

#import "YouhuiViewController.h"

@interface YouhuiViewController ()

@end

@implementation YouhuiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self removeColor];
    
    
}

//移动
-(void)removeColor{
    int indexICareAbout = 1;
    
    [[[[[self tabBarController] viewControllers] objectAtIndex: indexICareAbout] tabBarItem] setBadgeValue:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    self.imageView.image = [UIImage imageNamed:@"优惠券tab-未领取"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)getYouhui:(id)sender {

    self.imageView.image = [UIImage imageNamed:@"优惠券tab-已领取"];
}
@end
