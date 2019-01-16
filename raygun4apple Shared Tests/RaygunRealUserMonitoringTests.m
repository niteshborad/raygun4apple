//
//  RaygunRealUserMonitoringTests.m
//  raygun4apple
//
//  Created by Mitchell Duncan on 9/01/19.
//

#import <XCTest/XCTest.h>

#import "RaygunRealUserMonitoring.h"
#import "RaygunDefines.h"

@interface RaygunRealUserMonitoringTests : XCTestCase

@end

@implementation RaygunRealUserMonitoringTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testEventTypeNames {
    XCTAssertEqual(RaygunEventTypeNames[RaygunEventTypeSessionStart], @"session_start");
    XCTAssertEqual(RaygunEventTypeNames[RaygunEventTypeSessionEnd], @"session_end");
    XCTAssertEqual(RaygunEventTypeNames[RaygunEventTypeTiming], @"mobile_event_timing");
}

- (void)testEventTimingTypeNames {
    XCTAssertEqual(RaygunEventTimingTypeShortNames[RaygunEventTimingTypeViewLoaded], @"p");
    XCTAssertEqual(RaygunEventTimingTypeShortNames[RaygunEventTimingTypeNetworkCall], @"n");
}

- (void)testSharedInstance {
    RaygunRealUserMonitoring *rumInstance = [RaygunRealUserMonitoring sharedInstance];
    
    XCTAssertNotNil(rumInstance);
    XCTAssertNotNil(RaygunRealUserMonitoring.sharedInstance);
    XCTAssertEqual([rumInstance enabled], false);
}

- (void)testDefaultIgnoredViewsAdded {
    RaygunRealUserMonitoring *rumInstance = [[RaygunRealUserMonitoring alloc] init];

    XCTAssertNotNil(rumInstance);
    XCTAssertNotNil(rumInstance.ignoredViews);
    XCTAssertEqual([rumInstance.ignoredViews count], 2);
    XCTAssertEqual([rumInstance.ignoredViews containsObject:@"UINavigationController"], true);
    XCTAssertEqual([rumInstance.ignoredViews containsObject:@"UIInputWindowController"], true);
}

- (void)testAddingAViewToIgnore {
    RaygunRealUserMonitoring *rumInstance = [[RaygunRealUserMonitoring alloc] init];
    
    XCTAssertNotNil(rumInstance);
    XCTAssertNotNil(rumInstance.ignoredViews);
    XCTAssertEqual([rumInstance.ignoredViews count], 2);
    
    // Add the view we want to ignore
    [rumInstance ignoreViews:@[@"IgnoredViewName"]];
    
    XCTAssertEqual([rumInstance.ignoredViews count], 3); // The two default plus our TestView
    XCTAssertEqual([rumInstance.ignoredViews containsObject:@"IgnoredViewName"], true);
}

- (void)testStartTrackingAViewEvent {
    RaygunRealUserMonitoring *rumInstance = [[RaygunRealUserMonitoring alloc] init];
    
    XCTAssertNotNil(rumInstance);
    XCTAssertNotNil(rumInstance.viewEventTimers);
    XCTAssertEqual([rumInstance.viewEventTimers count], 0);
    
    [rumInstance startTrackingViewEventForKey:@"SetView" withTime:@(1.0)];
    
    XCTAssertEqual([rumInstance.viewEventTimers count], 1);
    
    NSNumber* time = [rumInstance.viewEventTimers valueForKey:@"SetView"];
    
    XCTAssertNotNil(time);
    XCTAssertEqual(time.doubleValue, 1.0);
}

- (void)testGettingAViewEventStartTime {
    RaygunRealUserMonitoring *rumInstance = [[RaygunRealUserMonitoring alloc] init];
    
    XCTAssertNotNil(rumInstance);
    XCTAssertNotNil(rumInstance.viewEventTimers);
    XCTAssertEqual([rumInstance.viewEventTimers count], 0);
    
    [rumInstance startTrackingViewEventForKey:@"GetView" withTime:@(2.0)];
    
    XCTAssertEqual([rumInstance.viewEventTimers count], 1);
    
    NSNumber* time = [rumInstance viewEventStartTimeForKey:@"GetView"];
    
    XCTAssertNotNil(time);
    XCTAssertEqual(time.doubleValue, 2.0);
}

- (void)testFinishingAViewEvent {
    RaygunRealUserMonitoring *rumInstance = [[RaygunRealUserMonitoring alloc] init];
    
    XCTAssertNotNil(rumInstance);
    XCTAssertNotNil(rumInstance.viewEventTimers);
    XCTAssertEqual([rumInstance.viewEventTimers count], 0);
    
    [rumInstance startTrackingViewEventForKey:@"FinishView" withTime:@(3.0)];
    
    XCTAssertEqual([rumInstance.viewEventTimers count], 1);
    
    [rumInstance finishTrackingViewEventForKey:@"FinishView" withTime:@(5.0)];

    XCTAssertEqual([rumInstance.viewEventTimers count], 0);
}

- (void)testDoNotTrackViewEventsWithNilKey {
    RaygunRealUserMonitoring *rumInstance = [[RaygunRealUserMonitoring alloc] init];
    
    XCTAssertNotNil(rumInstance);
    XCTAssertNotNil(rumInstance.viewEventTimers);
    XCTAssertEqual([rumInstance.viewEventTimers count], 0);
    
    [rumInstance startTrackingViewEventForKey:nil withTime:@(1.0)];
    
    XCTAssertEqual([rumInstance.viewEventTimers count], 0);
    XCTAssertNil([rumInstance viewEventStartTimeForKey:nil]);
}

@end