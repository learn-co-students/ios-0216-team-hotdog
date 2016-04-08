//
//  FMLMapViewDelegate.m
//  FarmersMarketLocator
//
//  Created by Magfurul Abeer on 4/1/16.
//  Copyright © 2016 Jeff Spingeld. All rights reserved.
//

#import "FMLMapViewDelegate.h"
#import "FMLMarket.h"
#import "FMLMarket+CoreDataProperties.h"
#import "FMLDetailView.h"
#import "Annotation.h"

@implementation FMLMapViewDelegate 


- (instancetype)init
{
    self = [self initWithTarget:nil];
    return self;
}

// Initializes with view controller so it's methods and properties can be accessed
- (instancetype)initWithTarget:(FMLMapViewController *)target
{
    self = [super init];
    if (self) {
        _viewController = target;
    }
    return self;
}


#pragma mark - MKMapView Delegate Methods

//
-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    self.selectedAnnotationView = view;
    
    if ([Annotation isSubclassOfClass:view.annotation.class]  ) {
        Annotation *annotation = (Annotation *)view.annotation;
        FMLMarket *market = self.viewController.marketsArray[ annotation.tag ];
        FMLDetailView *detailView = self.viewController.detailView;
        
        detailView.nameLabel.text = market.name.uppercaseString;
        detailView.addressLabel.text = [NSString stringWithFormat:@"ADDRESS: %@", market.address];
        detailView.produceTextView.text = [NSString stringWithFormat:@"AVAILABLE PRODUCE: %@", market.produceList];
        detailView.scheduleLabel.text = [NSString stringWithFormat:@"SCHEDULE: %@", market.scheduleString];
        
        //to use in yelp URL:
        detailView.zip = market.zipCode;
        
        //to use in maps URL for directions:
        detailView.selectedLatitude = [market.latitude floatValue];
        detailView.selectedLongitude = [market.longitude floatValue];
        
        if (mapView.region.span.longitudeDelta != detailView.previousRegion.span.longitudeDelta) {
            detailView.previousRegion = mapView.region;
        }
        
        [self.viewController zoomMaptoLatitude:[market.latitude floatValue]  longitude:[market.longitude floatValue] withLatitudeSpan:0.01 longitudeSpan:0.01];
        
        [detailView showDetailView];
    }
    
   
}

-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    [self.viewController.detailView hideDetailView];
}
@end
