//
//  PSAppTemplateAppDelegate.h
//  PSAppTemplate
//
//  Created by Peter Steinberger on 12.12.10.
//  Template by Peter Steinberger
//

#ifdef kUseCrashReporter
#import "CrashReportSender.h"
#endif

// suspend/kill delegate
#define kAppplicationWillSuspend @"kAppplicationWillSuspend"

@interface AppDelegate : NSObject <UIApplicationDelegate
#ifdef kUseCrashReporter
  ,CrashReportSenderDelegate
#endif
> {

  UIImageView            *splashView_;
  UIWindow               *window_;
  UINavigationController *navigationController_;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigationController;

@end

