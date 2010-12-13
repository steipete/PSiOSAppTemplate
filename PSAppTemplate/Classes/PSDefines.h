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

#ifdef APPSTORE
  #define kUseFlurryStatistics
#else
  #define kUseAutoUpdater
#endif


// keys & urls
#ifndef APPSTORE
  #define kBetaDistributionUrl @"http://yourserver.com/hockey/public/index.php"
#endif

#define kFlurryStatisticsKey @"INSERT_FLURRY_KEY"
#define kCrashReporterUrl @"http://path-to-crashreporter.com/crashreporter/crash_v200.php"
