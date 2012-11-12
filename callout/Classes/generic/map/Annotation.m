
// Several authors. Based on code by Asynchrony Solutions.
// See http://stackoverflow.com/questions/8018841/customize-the-mkannotationview-callout/8019308#8019308

#import "Annotation.h"

@implementation Annotation

@synthesize title          = _title;
@synthesize subtitle       = _subtitle;
@synthesize coordinate     = _coordinate;
@synthesize content        = _content;


/** Set coordinate and add itself to the mapview. */
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
    debug(@"\nOld: %f %f New: %f %f", _coordinate.latitude, _coordinate.longitude, newCoordinate.latitude, newCoordinate.longitude);
    _coordinate = newCoordinate;
    
    // not sure why or when this happens...
    // Add self to the map, and set self as the annotation for the referenced view.
    //[self.mapView addAnnotation:self];
    //if (_annotationView) {
    //    [_annotationView setAnnotation:self];
    //}
}



#pragma mark NSObject

/** Init with a coordinate and nil the rest. */
-(id) initWithContent:(Content*) content 
{
    self = [super init];
    if (self!=nil){
        self.content = content;
        self.coordinate = content.coordinate;
    }
    return self;
}


// disabled
- (id) init
{
    self = [super init];
    if (!self) return nil;
    [self release];
    [super doesNotRecognizeSelector:_cmd];
    return nil;
}

- (void)dealloc {
    [super dealloc];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"coordinate=%f,%f", self.coordinate.latitude, self.coordinate.longitude];
}

@end
