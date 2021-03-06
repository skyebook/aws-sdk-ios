/*
 Copyright 2010-2015 Amazon.com, Inc. or its affiliates. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License").
 You may not use this file except in compliance with the License.
 A copy of the License is located at

 http://aws.amazon.com/apache2.0

 or in the "license" file accompanying this file. This file is distributed
 on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 express or implied. See the License for the specific language governing
 permissions and limitations under the License.
 */

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "AWSTestUtility.h"
#import "AWSAutoScaling.h"

static id mockNetworking = nil;

@interface AWSGeneralAutoScalingTests : XCTestCase

@end

@implementation AWSGeneralAutoScalingTests

- (void)setUp {
    [super setUp];
    [AWSTestUtility setupFakeCognitoCredentialsProvider];

    mockNetworking = OCMClassMock([AWSNetworking class]);
    AWSTask *errorTask = [AWSTask taskWithError:[NSError errorWithDomain:@"OCMockExpectedNetworkingError" code:8848 userInfo:nil]];
    OCMStub([mockNetworking sendRequest:[OCMArg isKindOfClass:[AWSNetworkingRequest class]]]).andReturn(errorTask);
}

- (void)tearDown {
    [super tearDown];
}

- (void)testConstructors {
    NSString *key = @"testAutoScalingConstructors";
    XCTAssertNotNil([AWSAutoScaling defaultAutoScaling]);
    XCTAssertEqual([[AWSAutoScaling defaultAutoScaling] class], [AWSAutoScaling class]);
    XCTAssertNil([AWSAutoScaling AutoScalingForKey:key]);

    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionSAEast1 credentialsProvider:[AWSServiceManager defaultServiceManager].defaultServiceConfiguration.credentialsProvider];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];
    XCTAssertNotNil([AWSAutoScaling AutoScalingForKey:key]);
    XCTAssertEqual([[AWSAutoScaling AutoScalingForKey:key] class], [AWSAutoScaling class]);
    XCTAssertEqual([AWSAutoScaling AutoScalingForKey:key].configuration.regionType, AWSRegionSAEast1);

    [AWSAutoScaling removeAutoScalingForKey:key];
    XCTAssertNil([AWSAutoScaling AutoScalingForKey:key]);

}

- (void)testAttachInstances {
    NSString *key = @"testAttachInstances";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] attachInstances:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testCompleteLifecycleAction {
    NSString *key = @"testCompleteLifecycleAction";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] completeLifecycleAction:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testCreateAutoScalingGroup {
    NSString *key = @"testCreateAutoScalingGroup";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] createAutoScalingGroup:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testCreateLaunchConfiguration {
    NSString *key = @"testCreateLaunchConfiguration";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] createLaunchConfiguration:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testCreateOrUpdateTags {
    NSString *key = @"testCreateOrUpdateTags";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] createOrUpdateTags:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testDeleteAutoScalingGroup {
    NSString *key = @"testDeleteAutoScalingGroup";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] deleteAutoScalingGroup:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testDeleteLaunchConfiguration {
    NSString *key = @"testDeleteLaunchConfiguration";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] deleteLaunchConfiguration:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testDeleteLifecycleHook {
    NSString *key = @"testDeleteLifecycleHook";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] deleteLifecycleHook:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testDeleteNotificationConfiguration {
    NSString *key = @"testDeleteNotificationConfiguration";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] deleteNotificationConfiguration:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testDeletePolicy {
    NSString *key = @"testDeletePolicy";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] deletePolicy:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testDeleteScheduledAction {
    NSString *key = @"testDeleteScheduledAction";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] deleteScheduledAction:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testDeleteTags {
    NSString *key = @"testDeleteTags";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] deleteTags:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testDescribeAccountLimits {
    NSString *key = @"testDescribeAccountLimits";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] describeAccountLimits:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testDescribeAdjustmentTypes {
    NSString *key = @"testDescribeAdjustmentTypes";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] describeAdjustmentTypes:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testDescribeAutoScalingGroups {
    NSString *key = @"testDescribeAutoScalingGroups";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] describeAutoScalingGroups:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testDescribeAutoScalingInstances {
    NSString *key = @"testDescribeAutoScalingInstances";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] describeAutoScalingInstances:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testDescribeAutoScalingNotificationTypes {
    NSString *key = @"testDescribeAutoScalingNotificationTypes";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] describeAutoScalingNotificationTypes:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testDescribeLaunchConfigurations {
    NSString *key = @"testDescribeLaunchConfigurations";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] describeLaunchConfigurations:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testDescribeLifecycleHookTypes {
    NSString *key = @"testDescribeLifecycleHookTypes";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] describeLifecycleHookTypes:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testDescribeLifecycleHooks {
    NSString *key = @"testDescribeLifecycleHooks";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] describeLifecycleHooks:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testDescribeMetricCollectionTypes {
    NSString *key = @"testDescribeMetricCollectionTypes";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] describeMetricCollectionTypes:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testDescribeNotificationConfigurations {
    NSString *key = @"testDescribeNotificationConfigurations";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] describeNotificationConfigurations:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testDescribePolicies {
    NSString *key = @"testDescribePolicies";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] describePolicies:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testDescribeScalingActivities {
    NSString *key = @"testDescribeScalingActivities";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] describeScalingActivities:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testDescribeScalingProcessTypes {
    NSString *key = @"testDescribeScalingProcessTypes";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] describeScalingProcessTypes:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testDescribeScheduledActions {
    NSString *key = @"testDescribeScheduledActions";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] describeScheduledActions:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testDescribeTags {
    NSString *key = @"testDescribeTags";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] describeTags:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testDescribeTerminationPolicyTypes {
    NSString *key = @"testDescribeTerminationPolicyTypes";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] describeTerminationPolicyTypes:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testDetachInstances {
    NSString *key = @"testDetachInstances";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] detachInstances:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testDisableMetricsCollection {
    NSString *key = @"testDisableMetricsCollection";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] disableMetricsCollection:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testEnableMetricsCollection {
    NSString *key = @"testEnableMetricsCollection";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] enableMetricsCollection:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testEnterStandby {
    NSString *key = @"testEnterStandby";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] enterStandby:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testExecutePolicy {
    NSString *key = @"testExecutePolicy";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] executePolicy:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testExitStandby {
    NSString *key = @"testExitStandby";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] exitStandby:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testPutLifecycleHook {
    NSString *key = @"testPutLifecycleHook";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] putLifecycleHook:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testPutNotificationConfiguration {
    NSString *key = @"testPutNotificationConfiguration";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] putNotificationConfiguration:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testPutScalingPolicy {
    NSString *key = @"testPutScalingPolicy";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] putScalingPolicy:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testPutScheduledUpdateGroupAction {
    NSString *key = @"testPutScheduledUpdateGroupAction";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] putScheduledUpdateGroupAction:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testRecordLifecycleActionHeartbeat {
    NSString *key = @"testRecordLifecycleActionHeartbeat";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] recordLifecycleActionHeartbeat:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testResumeProcesses {
    NSString *key = @"testResumeProcesses";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] resumeProcesses:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testSetDesiredCapacity {
    NSString *key = @"testSetDesiredCapacity";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] setDesiredCapacity:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testSetInstanceHealth {
    NSString *key = @"testSetInstanceHealth";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] setInstanceHealth:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testSuspendProcesses {
    NSString *key = @"testSuspendProcesses";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] suspendProcesses:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testTerminateInstanceInAutoScalingGroup {
    NSString *key = @"testTerminateInstanceInAutoScalingGroup";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] terminateInstanceInAutoScalingGroup:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

- (void)testUpdateAutoScalingGroup {
    NSString *key = @"testUpdateAutoScalingGroup";
    AWSServiceConfiguration *configuration = [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUnknown credentialsProvider:nil];
    [AWSAutoScaling registerAutoScalingWithConfiguration:configuration forKey:key];

    AWSAutoScaling *awsClient = [AWSAutoScaling AutoScalingForKey:key];
    XCTAssertNotNil(awsClient);
    XCTAssertNotNil(mockNetworking);    [awsClient setValue:mockNetworking forKey:@"networking"];
    [[[[AWSAutoScaling AutoScalingForKey:key] updateAutoScalingGroup:nil] continueWithBlock:^id(AWSTask *task) {
        XCTAssertNotNil(task.error);
        XCTAssertEqualObjects(@"OCMockExpectedNetworkingError", task.error.domain);
        XCTAssertEqual(8848, task.error.code);
        XCTAssertNil(task.exception);
        XCTAssertNil(task.result);
        return nil;
    }] waitUntilFinished];

    OCMVerify([mockNetworking sendRequest:[OCMArg isNotNil]]);

    [AWSAutoScaling removeAutoScalingForKey:key];
}

@end
