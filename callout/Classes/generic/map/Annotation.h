
// Several authors. Based on code by Asynchrony Solutions.
// See http://stackoverflow.com/questions/8018841/customize-the-mkannotationview-callout/8019308#8019308

#import <MapKit/MapKit.h>
#import "AnnotationView.h"
#import "Content.h"


@interface Annotation : NSObject <MKAnnotation>


@property (nonatomic,assign) CLLocationCoordinate2D coordinate;
@property (nonatomic,retain) Content* content;

-(id) initWithContent:(Content*)content;

@end
