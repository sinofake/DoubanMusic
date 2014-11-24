#import <Foundation/Foundation.h>
@class DownloadHelper;

@protocol HttpDownloadDelegate <NSObject>
- (void)downloadCompleted:(DownloadHelper *)dh;

@optional
- (void)downloadError:(DownloadHelper *)dh;

@end
