//
//  PSAppTemplateAppDelegate.h
//  PSAppTemplate
//
//  Created by Peter Steinberger on 12.12.10.
//  Template by Peter Steinberger
//

#import "PSDefines.h"
#import "PSWindow.h"

#ifdef kUseCrashReporter
#import "CrashReportSender.h"
#endif

#ifdef kUseAutoUpdater
#import "BWHockeyManager.h"
#endif

@interface AppDelegate : NSObject <UIApplicationDelegate, PSReachabilityAware
#ifdef kUseCrashReporter
  ,CrashReportSenderDelegate
#endif
#ifdef kUseAutoUpdater
  ,BWHockeyManagerDelegate
#endif
> {
  PSWindow               *window_;
  UINavigationController *navigationController_;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigationController;

@end

