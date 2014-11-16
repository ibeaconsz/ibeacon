//
//  ViewController.m
//  Ibeacon
//
//  Created by chenwg on 14-11-15.
//  Copyright (c) 2014年 chenwg.com. All rights reserved.
//

#import "ViewController.h"
#import "APLDefaults.h"
#import "LineView.h"

@import CoreLocation;
@interface ViewController ()<CLLocationManagerDelegate,UIAlertViewDelegate>
{
    BOOL isGetA;
    BOOL stopGetAData;
    BOOL starNavFlag;
}
@property NSMutableDictionary *beacons;
@property CLLocationManager *locationManager;
@property NSMutableDictionary *rangedRegions;

@property (nonatomic, strong) UILabel *distanceLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.wcAddress.hidden = true;
    self.escalatorAddress.hidden = true;
    [_mylocation.layer setCornerRadius:CGRectGetWidth(_mylocation.frame)/2];
    _distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 420, 300, 30)];
    _distanceLabel.textColor = [UIColor blueColor];
    [self.view addSubview:_distanceLabel];
    
    UIButton *starNav = [UIButton buttonWithType:UIButtonTypeCustom];
    starNav.frame = CGRectMake(220, 450, 80, 30);
    [starNav setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [starNav setTitle:@"开始导航" forState:UIControlStateNormal];
    [starNav addTarget:self action:@selector(onStarNavButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:starNav];
    
    [_escalatorAddress addTarget:self action:@selector(onESCbuttonAction:) forControlEvents:UIControlEventTouchUpInside];
    starNavFlag = NO;
    [self initIbeacon];
    
    
    
}

//颜色
-(void)initColor{
    int indexICareAbout = 2;
    
    NSString *badgeValue = @"10";
    
    [[[[[self tabBarController] viewControllers] objectAtIndex: indexICareAbout] tabBarItem] setBadgeValue:badgeValue];
    
    
}

//移动
-(void)removeColor{
    int indexICareAbout = 2;
    
    [[[[[self tabBarController] viewControllers] objectAtIndex: indexICareAbout] tabBarItem] setBadgeValue:nil];
}

- (IBAction)onStarNavButtonAction:(id)sender
{
    starNavFlag = YES;
}

- (IBAction)onESCbuttonAction:(id)sender
{
    self.escalatorAddress.hidden = NO;
    //寒星画线
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"寒星画线" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    
    LineView *line = [[LineView alloc] initWithFrame:self.view.bounds withX:_mylocation.frame.origin.x Y:_mylocation.frame.origin.y];
    [self.view addSubview:line];
    stopGetAData = NO;
    [_mylocation setBackgroundColor:[UIColor greenColor]];
    
}

- (void)initIbeacon
{
    self.beacons = [[NSMutableDictionary alloc] init];
    
    // This location manager will be used to demonstrate how to range beacons.
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    // Populate the regions we will range once.
    self.rangedRegions = [[NSMutableDictionary alloc] init];
    
    for (NSUUID *uuid in [APLDefaults sharedDefaults].supportedProximityUUIDs)
    {
        CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:[uuid UUIDString]];
        self.rangedRegions[region] = [NSArray array];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Start ranging when the view appears.
    for (CLBeaconRegion *region in self.rangedRegions)
    {
        [self.locationManager startRangingBeaconsInRegion:region];
    }
}

#pragma mark - Location manager delegate

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    /*
     CoreLocation will call this delegate method at 1 Hz with updated range information.
     Beacons will be categorized and displayed by proximity.  A beacon can belong to multiple
     regions.  It will be displayed multiple times if that is the case.  If that is not desired,
     use a set instead of an array.
     */
    self.rangedRegions[region] = beacons;
    [self.beacons removeAllObjects];
    
    NSMutableArray *allBeacons = [NSMutableArray array];
    
    for (NSArray *regionResult in [self.rangedRegions allValues])
    {
        [allBeacons addObjectsFromArray:regionResult];
    }
    
    for (NSNumber *range in @[@(CLProximityUnknown), @(CLProximityImmediate), @(CLProximityNear), @(CLProximityFar)])
    {
        NSArray *proximityBeacons = [allBeacons filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"proximity = %d", [range intValue]]];
        if([proximityBeacons count])
        {
            self.beacons[range] = proximityBeacons;
        }
    }
    
//    NSLog(@"beacons : %@",self.beacons)÷
    
    if (self.beacons.count && starNavFlag) {
        // Display the UUID, major, minor and accuracy for each beacon.
        NSNumber *sectionKey = [self.beacons allKeys][0];
        CLBeacon *beacon = self.beacons[sectionKey][0];
        //    cell.textLabel.text = [beacon.proximityUUID UUIDString];
        
        NSString *formatString = NSLocalizedString(@"Acc: %.2fm, RSSI : %d", @"Format string for ranging table cells.");
        _distanceLabel.text = [NSString stringWithFormat:@"Acc: %.2fm, RSSI : %d",beacon.accuracy, beacon.rssi];
        
        NSString *temp = [NSString stringWithFormat:@"%.2f",beacon.accuracy];
        
        NSInteger yy = sqrt(([temp floatValue]*1000)*([temp floatValue]*1000) - 80*80);
        
//        NSLog(@"%.2f",(beacon.accuracy*1000)*(beacon.accuracy)*1000);
        NSLog(@"xxx:%d",yy);
        if (yy > 0 && !stopGetAData) {
            CGRect frame = _mylocation.frame;
//            frame.origin.x = _wcAddress.center.x+80;
            if (isGetA) {
                frame.origin.y = _wcAddress.frame.origin.y-[temp floatValue]*100 < CGRectGetMinY(_escalatorAddress.frame) ? CGRectGetMinY(_escalatorAddress.frame) : _wcAddress.frame.origin.y-[temp floatValue]*100;
                if (frame.origin.y == CGRectGetMinY(_escalatorAddress.frame)) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"到达扶梯,演示结束" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alertView show];
                    stopGetAData = YES;
                    [_mylocation setBackgroundColor:[UIColor purpleColor]];
                }
            }
            else{
                frame.origin.y = _wcAddress.frame.origin.y+[temp floatValue]*100 < CGRectGetMinY(_escalatorAddress.frame) ? CGRectGetMinY(_escalatorAddress.frame) : _wcAddress.frame.origin.y+[temp floatValue]*100;
                if (frame.origin.y <= _wcAddress.frame.origin.y + 50 && frame.origin.y >= _wcAddress.frame.origin.y - 50) {
                    isGetA = YES;
                    frame.origin.y = _wcAddress.frame.origin.y;
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"到达洗手间" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alertView show];
                    [self initColor];
                    stopGetAData = YES;
                    [_mylocation setBackgroundColor:[UIColor redColor]];
                }
            }
            
            
//            frame.origin.y = 212+[temp floatValue]*100 < CGRectGetMinY(_escalatorAddress.frame) ? CGRectGetMinY(_escalatorAddress.frame) : 212+[temp floatValue]*100;
            _mylocation.frame = frame;
            
        }
        

    }

    
    
    
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    
}

#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    stopGetAData = NO;
//    [_mylocation setBackgroundColor:[UIColor greenColor]];
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
