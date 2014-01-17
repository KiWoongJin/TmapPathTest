//
//  ViewController.m
//  TmapPathTest
//
//  Created by SDT-1 on 2014. 1. 17..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "ViewController.h"
#import "TMapView.h"

#define APP_KEY @"9808e4e1-db20-3f1f-8b3c-77606b3b71a1"
#define TOOLBAR_HIGHT 60

@interface ViewController () <TMapViewDelegate>
@property (strong, nonatomic)TMapView *mapView;
@property (strong, nonatomic)TMapMarkerItem *startMarker, *endMarker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *transportType;

@end

@implementation ViewController
- (IBAction)transportTypeChanged:(id)sender {
    [self showPath];
}

- (void)showPath{
    TMapPathData *path = [[TMapPathData alloc]init];
    TMapPolyLine *line = [path findPathDataWithType:self.transportType.selectedSegmentIndex startPoint:[self.startMarker getTMapPoint] endPoint:[self.endMarker getTMapPoint]];
    
    if (nil != line) {
        [self.mapView showFullPath:@[line]];
        [self.mapView bringMarkerToFront:self.startMarker];
        [self.mapView bringMarkerToFront:self.endMarker];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [self showPath];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CGRect rect = CGRectMake(0, TOOLBAR_HIGHT, self.view.frame.size.width, self.view.frame.size.height - TOOLBAR_HIGHT);
    self.mapView = [[TMapView alloc]initWithFrame:rect];
    [self.mapView setSKPMapApiKey:APP_KEY];
    [self.view addSubview:self.mapView];
    
    self.startMarker = [[TMapMarkerItem alloc]init];
    [self.startMarker setIcon:[UIImage imageNamed:@"icon_clustering.png"]];
    TMapPoint *startPoint = [self.mapView convertPointToGpsX:50 andY:50];
    [self.startMarker setTMapPoint:startPoint];
    [self.mapView addCustomObject:self.startMarker ID:@"START"];
    
    self.endMarker = [[TMapMarkerItem alloc]init];
    [self.endMarker setIcon:[UIImage imageNamed:@"icon_clustering.png"]];
    TMapPoint *endPoint = [self.mapView convertPointToGpsX:300 andY:300];
    [self.endMarker setTMapPoint:endPoint];
    [self.mapView addCustomObject:self.endMarker ID:@"END"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
