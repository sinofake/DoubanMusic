#import <UIKit/UIKit.h>

@interface CustomButton : UIButton

- (id)initWithFrame:(CGRect)frame title:(NSString *)title;
- (void)hiddenCurrentLabel;
- (void)showCurrentLabel;

@end
