//
//  ViewController.m
//  Ibeacon
//
//  Created by chenwg on 14-11-15.
//  Copyright (c) 2014年 chenwg.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.wcAddress.hidden = true;
    self.escalatorAddress.hidden = true;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)wcAction:(id)sender {
    if (self.wcAddress.hidden == false) {
        self.wcAddress.hidden = true;
    }else{
        self.wcAddress.hidden = false;
    }
}

- (IBAction)escalatorAction:(id)sender {
    if (self.escalatorAddress.hidden == false) {
        self.escalatorAddress.hidden = true;
    }else{
        self.escalatorAddress.hidden = false;
    }
}
@end
