
// Several authors. Based on code by Asynchrony Solutions.
// See http://stackoverflow.com/questions/8018841/customize-the-mkannotationview-callout/8019308#8019308

#import "AnnotationView.h"
#import "CalloutAnnotation.h"

@implementation CalloutAnnotation

@synthesize parentAnnotationView = _parentAnnotationView;
@synthesize mapView = _mapView;
@synthesize content = _content;
@synthesize coordinate = _coordinate;


#pragma mark - accessors

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    _coordinate = newCoordinate;
}

- (CLLocationCoordinate2D)coordinate {
    return _coordinate;
}


#pragma mark - NSObject

/** Init with a coordinate. */
- (id) initWithContent:(Content*)content {
    self = [super init];
    if (self){
        self.content = content;
        self.coordinate = content.coordinate;
    }
    return self;
}


- (void)dealloc {
    self.content = nil;
    [super dealloc];
}

@end
