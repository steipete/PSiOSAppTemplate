//
//  PSDefines.h
//  PSAppTemplate
//
//  Created by Peter Steinberger on 12.12.10.
//

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Template Configuration
////////////////////////////////////////////////////////////////////////

#define kIntroFadeAnimation
#define kUseCrashReporter
#define kCrashReporterFeedbackEnabled NO      // boolean switch
#define kPostFinishLaunchDelay        1.5     // set to positive value to call postFinishLaunch in AppDelegate after delay

#ifdef DEBUG
#define kMemoryWarningAfterDeviceShake
#endif

#ifdef APPSTORE
  #define kUseFlurryStatistics
#else
  #define kUseAutoUpdater
#endif

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark DCInstropect - Awesome visual debugging
////////////////////////////////////////////////////////////////////////

#ifdef TARGET_IPHONE_SIMULATOR
    #define kDCIntrospectEnabled
#endif


////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark URLs
////////////////////////////////////////////////////////////////////////

#ifndef APPSTORE
  #define kHockeyUpdateDistributionUrl @"http://petersteinberger.com/appstore"
#endif

#define kCrashReporterUrl       @"http://path-to-crashreporter.com/crashreporter/crash_v200.php"
#define kReachabilityHostURL    @"www.apple.com"

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Keys
////////////////////////////////////////////////////////////////////////

#define kFlurryStatisticsKey @"INSERT_FLURRY_KEY"

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Notifications
////////////////////////////////////////////////////////////////////////

// suspend/kill delegate
#define kAppplicationWillSuspendNotification @"kAppplicationWillSuspendNotification"
// device shaken
#define kDeviceWasShakenNotification         @"kDeviceWasShakenNotification"