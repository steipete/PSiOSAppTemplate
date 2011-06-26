//
//  PSAppTemplateAppDelegate.m
//  PSAppTemplate
//
//  Created by Peter Steinberger on 12.12.10.
//  Template by Peter Steinberger
//

#import "AppDelegate.h"
#import "PSIncludes.h"
#import "BWHockeyManager.h"
#import "RootViewController.h"

#ifdef kUseFlurryStatistics
#import "FlurryAPI.h"
#endif

#ifdef kDCIntrospectEnabled
#import "DCIntrospect.h"
#endif


@interface AppDelegate ()

- (void)configureLogger;
- (void)appplicationPrepareForBackgroundOrTermination:(UIApplication *)application;
- (void)postFinishLaunch;
@end


@implementation AppDelegate

@synthesize window = window_;
@synthesize navigationController = navigationController_;


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSObject
///////////////////////////////////////////////////////////////////////////////////////////////////

- (void)dealloc {
    MCRelease(window_);
    MCRelease(navigationController_);
    
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIApplicationDelegate
///////////////////////////////////////////////////////////////////////////////////////////////////

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self configureLogger];
    DDLogInfo(_(@"PSTemplateWelcomeMessage"));
    
#ifdef kUseCrashReporter
    [[CrashReportSender sharedCrashReportSender] sendCrashReportToURL:[NSURL URLWithString:kCrashReporterUrl] 
                                                             delegate:self activateFeedback:kCrashReporterFeedbackEnabled];
#endif
    
    // check for NSZombie (memory leak if enabled, but very useful!)
    if(getenv("NSZombieEnabled") || getenv("NSAutoreleaseFreedObjectCheckEnabled")) {
        DDLogWarn(@"NSZombieEnabled / NSAutoreleaseFreedObjectCheckEnabled enabled! Disable for release.");
    }
    
    // Add the navigation controller's view to the window and display.
    RootViewController *rootController = [[[RootViewController alloc] initWithStyle:UITableViewStylePlain] autorelease];
    navigationController_ = [[UINavigationController alloc] initWithRootViewController:rootController];
    window_ = [[PSWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    window_.rootViewController = navigationController_;
    [window_ makeKeyAndVisible];
    
    // fade animation!
#ifdef kIntroFadeAnimation
    MTSplashScreen *splashScreen = [MTSplashScreen splashScreen];
    [self.navigationController presentModalViewController:splashScreen animated:NO];
#endif
    
    // visual debugging!
#ifdef kDCIntrospectEnabled
    [[DCIntrospect sharedIntrospector] start];
#endif
    
#if !defined (APPSTORE)
    DDLogInfo(@"Autoupdate is enabled.");
    [BWHockeyManager sharedHockeyManager].updateURL = kHockeyUpdateDistributionUrl;
    [BWHockeyManager sharedHockeyManager].delegate = self;
    [BWHockeyManager sharedHockeyManager].alwaysShowUpdateReminder = YES;  
#endif
    
    if (kPostFinishLaunchDelay > 0) {
        [self performSelector:@selector(postFinishLaunch) withObject:nil afterDelay:kPostFinishLaunchDelay];
    }
   
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self appplicationPrepareForBackgroundOrTermination:application];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
    [self appplicationPrepareForBackgroundOrTermination:application];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Memory management
///////////////////////////////////////////////////////////////////////////////////////////////////

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    // TODO: Release memory, or hell freazes over!
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark CrashReportSenderDelegate AND BWHockeyManagerDelegate
///////////////////////////////////////////////////////////////////////////////////////////////////

#if defined(kUseCrashReporter) || defined(kUseAutoUpdater)
- (void)connectionOpened {
    [[IKNetworkActivityManager sharedInstance] addNetworkUser:self];
}

- (void)connectionClosed {
    [[IKNetworkActivityManager sharedInstance] removeNetworkUser:self];
}
#endif

#if defined(kUseCrashReporter)
- (NSString *)crashReportDescription {
    NSString *deviceInfo = [UIDevice debugInfo];
    DDLogInfo(deviceInfo);
    
    return deviceInfo;
}
#endif

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Reachability
///////////////////////////////////////////////////////////////////////////////////////////////////

- (void)configureForNetworkStatus:(NSNotification *)notification {
    // NetworkStatus networkStatus = [[notification.userInfo valueForKey:kPSNetworkStatusKey] intValue];
    
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Private Methods
///////////////////////////////////////////////////////////////////////////////////////////////////

- (void)configureLogger {
    PSDDFormatter *psLogger = [[[PSDDFormatter alloc] init] autorelease];
    [[DDTTYLogger sharedInstance] setLogFormatter:psLogger];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
#ifndef APPSTORE
    // log to file
    DDFileLogger *fileLogger = [[[DDFileLogger alloc] init] autorelease];
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger];
    
#ifndef DISTRIBUTION
    // log to network (disabled for now, as it breaks clang 1.7)
    // [DDLog addLogger:[DDNSLoggerLogger sharedInstance]];
#endif
    
#endif
}

- (void)appplicationPrepareForBackgroundOrTermination:(UIApplication *)application {
    DDLogInfo(@"detected application termination.");
    
    // post notification to all listeners
    [[NSNotificationCenter defaultCenter] postNotificationName:kAppplicationWillSuspendNotification object:application];
    [[PSReachability sharedPSReachability] shutdownReachabilityFor:self];
}

// launched via post selector to speed up launch time
- (void)postFinishLaunch {
#ifdef kUseFlurryStatistics
    [FlurryAPI startSession:kFlurryStatisticsKey];
#endif
    
    [[PSReachability sharedPSReachability] startCheckingHostAddress:kReachabilityHostURL];
    [[PSReachability sharedPSReachability] setupReachabilityFor:self];
}

@end

