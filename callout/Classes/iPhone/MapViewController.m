
// Several authors. Based on code by Asynchrony Solutions.
// See http://stackoverflow.com/questions/8018841/customize-the-mkannotationview-callout/8019308#8019308

#import "MapViewController.h"
#import "CalloutAnnotation.h"
#import "MyCalloutView.h"
#import "AnnotationView.h"
#import "MySecondCalloutView.h"

/**
 * Delegates (de)selection to a view conforming to the AnnotationViewProtocol.
 * Delegates creation of the view to an annotation conforming to the AnnotationProtocol.
 */
@implementation MapViewController

@synthesize mapView;


-(void)viewDidLoad
{
    UIButton *zoom_in_button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [zoom_in_button addTarget:self
                       action:@selector(leftButton:)
             forControlEvents:UIControlEventTouchDown];
    [zoom_in_button setTitle:@"+" forState:UIControlStateNormal];
    zoom_in_button.frame = CGRectMake(0.0, 230.0, 50.0, 40.0);
    [mapView addSubview:zoom_in_button];
}


// toolbar button
-(IBAction) leftButton:(id)sender 
{   
    // create 10 annotations
    NSArray *annotations = [MapUtil createAnnotationsForVisibleMap:self.mapView number:10];
    [self.mapView addAnnotations:annotations];
}


#pragma mark - MKMapViewDelegate

/** 
 * Delegates the SELECTION to the view implementation.
 */
- (void)mapView:(MKMapView *)aMapView didSelectAnnotationView:(MKAnnotationView *)view 
{
    debug(@".");
    // delegate the implementation to the annotation view
    if ([view conformsToProtocol:@protocol(AnnotationViewProtocol)]) {
        debug(@"%@ conforms", NSStringFromClass([view class]));
        [((NSObject<AnnotationViewProtocol>*)view) didSelectAnnotationViewInMap:mapView];
    } else {
        debug(@"%@ DOES NOT conform", NSStringFromClass([view class]));
    }
}


/** 
 * Delegates the DESELECTION to the view implementation.
 */
- (void)mapView:(MKMapView *)aMapView didDeselectAnnotationView:(MKAnnotationView *)view 
{
    debug(@"%@", [view class]);
    // delegate the implementation to the annotation view
    if ([view conformsToProtocol:@protocol(AnnotationViewProtocol)]) {
        [((NSObject<AnnotationViewProtocol>*)view) didDeselectAnnotationViewInMap:mapView];
    }
}


/** 
 * Delegates CREATION of the view to the annotation.
 * 
 * If the annotation doesn't conform to AnnotationProtocol, 
 * a standard MKPinAnnotationView is returned.
 */
- (MKAnnotationView *)mapView:(MKMapView *)aMapView viewForAnnotation:(id<MKAnnotation>)annotation 
{
    NSLog(@"%s",__FUNCTION__);
    if ([annotation isKindOfClass:[Annotation class]]) {

        static NSString *viewId = @"AnnotationView";
        AnnotationView *annotationView = (AnnotationView*)[aMapView dequeueReusableAnnotationViewWithIdentifier:viewId];
        if (annotationView==nil){
            annotationView = [[[AnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:viewId] autorelease];
            return annotationView;
            
        }
        else
        {
            annotationView.annotation = annotation;
            
        }
        return annotationView;
            
    }
    
    if ([annotation isKindOfClass:[CalloutAnnotation class]])
    {
        // dequeue or create a MKAnnotationView
        static NSString *viewId = @"CalloutAnnotationView";
        
        MyCalloutView *calloutView = (MyCalloutView *)[aMapView dequeueReusableAnnotationViewWithIdentifier:viewId];
        
        
        if (calloutView==nil) {
                calloutView = [[[MyCalloutView alloc] initWithAnnotation:(CalloutAnnotation *)annotation] autorelease];
        }
        else
        {
            calloutView.annotation = annotation;
            calloutView.parentAnnotationView = ((CalloutAnnotation *)annotation).parentAnnotationView;
            
        }
        return calloutView;
        
    }
    else
    {
        
        // else, return a standard annotation view
        static NSString *viewId = @"MKPinAnnotationView";
        MKAnnotationView *view = (MKPinAnnotationView*) [self.mapView dequeueReusableAnnotationViewWithIdentifier:viewId];
        if (view == nil) {
            view = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:viewId] autorelease];
        }
        return view;
    }
}


#pragma mark - NSObject

- (void)dealloc {
    mapView.delegate=nil;
    [super dealloc];
}


@end
