//
//  RaygunDefines.h
//  raygun4apple
//
//  Created by Mitchell Duncan on 27/08/18.
//  Copyright © 2018 Raygun Limited. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall remain in place
// in this source code.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#ifndef RaygunDefines_h
#define RaygunDefines_h

#import <Foundation/Foundation.h>

#if TARGET_OS_IOS || TARGET_OS_TV
#define RAYGUN_CAN_USE_UIDEVICE 1
#else
#define RAYGUN_CAN_USE_UIDEVICE 0
#endif

#if RAYGUN_CAN_USE_UIDEVICE
#define RAYGUN_CAN_USE_UIKIT 1
#else
#define RAYGUN_CAN_USE_UIKIT 0
#endif

static NSString *_Nonnull const kRaygunClientVersion = @"1.0.0";

static NSString *_Nonnull const kRaygunIdentifierUserDefaultsKey = @"com.raygun.identifier";
static NSString *_Nonnull const kRaygunSessionLastSeenDefaultsKey = @"com.raygun.session.lastseen";

static NSString *_Nonnull const kApiEndPointForCR  = @"https://api.raygun.com/entries";
static NSString *_Nonnull const kApiEndPointForRUM = @"https://api.raygun.com/events";

static double kSessionExpiryPeriodInSeconds = 30.0 * 60.0; // 30 minutes

@class RaygunMessage;

/**
 * Block can be used to modify the crash report before it is sent to Raygun.
 */
typedef BOOL (^RaygunBeforeSendMessage)(RaygunMessage *_Nonnull message);

typedef NS_ENUM(NSInteger, RaygunEventType) {
    kRaygunEventTypeSessionStart = 0,
    kRaygunEventTypeSessionEnd,
    kRaygunEventTypeTiming
};

/**
 * Static internal helper to convert enum to string
 */
static NSString *_Nonnull const RaygunEventTypeNames[] = {
    @"session_start",
    @"session_end",
    @"mobile_event_timing"
};

typedef NS_ENUM(NSInteger, RaygunEventTimingType) {
    kRaygunEventTimingViewLoaded = 0,
    kRaygunEventTimingNetworkCall
};

/**
 * Static internal helper to convert enum to string
 */
static NSString *_Nonnull const RaygunEventTimingTypeShortNames[] = {
    @"p",
    @"n"
};

typedef NS_ENUM(NSInteger, RaygunLoggingLevel) {
    kRaygunLoggingLevelNone = 0,
    kRaygunLoggingLevelError,
    kRaygunLoggingLevelWarning,
    kRaygunLoggingLevelDebug,
    kRaygunLoggingLevelVerbose,
};

/**
 * Static internal helper to convert enum to string
 */
static NSString *_Nonnull const RaygunLoggingLevelNames[] = {
    @"None",
    @"Error",
    @"Warning",
    @"Debug",
    @"Verbose"
};

static inline BOOL IsNullOrEmpty(id _Nullable thing) {
    return thing == nil || ([thing respondsToSelector:@selector(length)] && ((NSData *)thing).length == 0)
                        || ([thing respondsToSelector:@selector(count)] && ((NSArray *)thing).count == 0);
}

#endif /* RaygunDefines_h */
