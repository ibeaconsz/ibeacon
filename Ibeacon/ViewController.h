//
//  ViewController.h
//  Ibeacon
//
//  Created by chenwg on 14-11-15.
//  Copyright (c) 2014年 chenwg.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *escalatorAddress;
@property (strong, nonatomic) IBOutlet UIButton *wcAddress;

- (IBAction)wcAction:(id)sender;

- (IBAction)escalatorAction:(id)sender;

@end
