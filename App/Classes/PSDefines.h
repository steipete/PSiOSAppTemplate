//
//  PSDefines.h
//  PSAppTemplate
//
//  Created by Peter Steinberger on 12.12.10.
//

// configure template

#define kIntroFadeAnimation
#define kUseCrashReporter
#define kCrashReporterFeedbackEnabled NO // boolean switch

// awesome visual debugging
#ifdef TARGET_IPHONE_SIMULATOR
    #define kDCIntrospectEnabled
#endif

#ifdef APPSTORE
  #define kUseFlurryStatistics
#else
  #define kUseAutoUpdater
#endif


// keys & urls
#ifndef APPSTORE
  #define kHockeyUpdateDistributionUrl @"http://petersteinberger.com/appstore"
#endif

#define kFlurryStatisticsKey @"INSERT_FLURRY_KEY"
#define kCrashReporterUrl @"http://path-to-crashreporter.com/crashreporter/crash_v200.php"