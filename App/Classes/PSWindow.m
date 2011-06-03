//
//  PSWindow.m
//  PSAppTemplate
//
//  Created by Matthias Tretter on 03.06.11.
//  Copyright 2011 @myell0w. All rights reserved.
//

#import "PSWindow.h"
#import "PSIncludes.h"


@implementation PSWindow

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.type == UIEventTypeMotion && event.subtype == UIEventSubtypeMotionShake) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kDeviceWasShakenNotification object:self];
        
#ifdef kMemoryWarningAfterDeviceShake
        DDLogInfo(@"Detected Device Shake, will simulate memory warning");
        PSSimulateMemoryWarning();
#else
        [super motionEnded:motion withEvent:event];
#endif
        
    } else {
        [super motionEnded:motion withEvent:event];
    }
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    [super remoteControlReceivedWithEvent:event];
    
	// Handle Remote Control Event
	if (event.type == UIEventTypeRemoteControl) {
		switch (event.subtype) {
			case UIEventSubtypeRemoteControlPlay:
                break;
                
			case UIEventSubtypeRemoteControlTogglePlayPause:
				break;
                
			case UIEventSubtypeRemoteControlPause:
                break;
                
			case UIEventSubtypeRemoteControlStop:
				break;
                
			case UIEventSubtypeRemoteControlPreviousTrack:
				break;
                
			case UIEventSubtypeRemoteControlNextTrack:
				break;
                
			case UIEventSubtypeRemoteControlBeginSeekingForward:
				break;
                
			case UIEventSubtypeRemoteControlEndSeekingForward:
				break;
                
			case UIEventSubtypeRemoteControlBeginSeekingBackward:
				break;
                
			case UIEventSubtypeRemoteControlEndSeekingBackward:
				break;
                
			default:
				break;
		}
	}
}

@end
