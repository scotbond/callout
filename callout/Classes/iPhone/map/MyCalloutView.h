
// Several authors. Based on code by Asynchrony Solutions.
// See http://stackoverflow.com/questions/8018841/customize-the-mkannotationview-callout/8019308#8019308

#import "CalloutAnnotation.h"
#import "BaseCalloutView.h"

@interface MyCalloutView : BaseCalloutView

@property (nonatomic, retain) IBOutlet UILabel* title;

-(IBAction) handleTouch:(id)sender;
- (id) initWithAnnotation:(CalloutAnnotation*)annotation;

@end
