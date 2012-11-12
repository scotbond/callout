// Several authors. Based on code by Asynchrony Solutions.
// See http://stackoverflow.com/questions/8018841/customize-the-mkannotationview-callout/8019308#8019308

#import "MyCalloutView.h"


@implementation MyCalloutView

@synthesize title = _title;


-(IBAction) handleTouch:(id)sender {
    debug(@"touch %@", sender);
}


- (id)initWithAnnotation:(CalloutAnnotation*)annotation {
    NSString *identifier = NSStringFromClass([self class]);
    self = [super initWithAnnotation:annotation reuseIdentifier:identifier];
    self.title.text = [annotation.content.values objectForKey:@"title"];
    return self;
}

- (void)setAnnotation:(CalloutAnnotation *)annotation
{
    self.title.text = [annotation.content.values objectForKey:@"title"];
    [super setAnnotation:annotation];
}

#pragma mark - NSObject

- (void)dealloc {
    self.title = nil;
    [super dealloc];
}


@end
