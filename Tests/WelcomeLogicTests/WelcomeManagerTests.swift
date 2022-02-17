//
//  WelcomeManagerTests.swift
//  
//
//  Created by Nikolai Nobadi on 2/15/22.
//

import XCTest
import TestHelpers
import WelcomeLogic

final class WelcomeManagerTests: XCTestCase {
    
    func test_init_noErrors() {
        let (_, alerts, _) = makeSUT()
        
        XCTAssertNil(alerts.error)
    }
    
    func test_finishWelcome_usernameNOTRequired_uploadError() {
        let (sut, alerts, remote) = makeSUT()
        
        sut.finishWelcome(getTestName(.firstName))
        remote.finishedComplete(with: NSError(domain: "Test", code: 0))
        XCTAssertNotNil(alerts.error)
    }
    
    func test_finishWelcome_usernameNOTRequired_uploadSuccess() {
        let exp = expectation(description: "waiting for ...")
        let (sut, _, remote) = makeSUT { exp.fulfill() }
        
        sut.finishWelcome(getTestName(.firstName))
        remote.finishedComplete(with: nil)
        
        waitForExpectations(timeout: 0.1)
    }
    
    func test_finishWelcome_usernameRequired_dupeError() {
        let (sut, alerts, remote) = makeSUT(usernameRequired: true)
        
        sut.finishWelcome(getTestName(.firstName))
        remote.dupeComplete(with: NSError(domain: "Test", code: 0))
        XCTAssertNotNil(alerts.error)
    }
    
    func test_finishWelcome_usernameRequired_dupeSuccess_uploadError() {
        let (sut, alerts, remote) = makeSUT(usernameRequired: true)
        
        sut.finishWelcome(getTestName(.firstName))
        remote.dupeComplete(with: nil)
        remote.finishedComplete(with: NSError(domain: "Test", code: 0))
        XCTAssertNotNil(alerts.error)
    }
    
    func test_finishWelcome_usernameRequired_dupeSuccess_uploadSuccess() {
        let exp = expectation(description: "waiting for ...")
        let (sut, _, remote) = makeSUT(usernameRequired: true) { exp.fulfill()
        }
        
        sut.finishWelcome(getTestName(.firstName))
        remote.dupeComplete(with: nil)
        remote.finishedComplete(with: nil)
        
        waitForExpectations(timeout: 0.1)
    }
}


// MARK: - SUT
extension WelcomeManagerTests {
    
    func makeSUT(usernameRequired: Bool = false,
                 finished: @escaping () -> Void = { },
                 file: StaticString = #filePath, line: UInt = #line) -> (sut: WelcomeManager, alerts: MockWelcomeManagerAlerts, remote: WelcomeManagerRemoteAPISpy) {
        
        let alerts = MockWelcomeManagerAlerts()
        let remote = WelcomeManagerRemoteAPISpy()
        let sut = WelcomeManager(remote: remote,
                                 alerts: alerts,
                                 usernameRequired: usernameRequired,
                                 finished: finished)
        
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, alerts, remote)
    }
}


// MARK: - Helper Classes
extension WelcomeManagerTests {
    
    class MockWelcomeManagerAlerts: WelcomeManagerAlerts {
        
        var error: Error?
        
        func showError(_ error: Error) {
            self.error = error
        }
    }
    
    class WelcomeManagerRemoteAPISpy: WelcomeManagerRemoteAPI {
        
        private var dupeCompletion: ((Error?) -> Void)?
        private var finishedCompletion: ((Error?) -> Void)?
        
        func checkForDuplicates(_ name: String,
                                completion: @escaping (Error?) -> Void) {
            
            dupeCompletion = completion
        }
        
        func finishWelcome(username: String?,
                           completion: @escaping (Error?) -> Void) {
            
            finishedCompletion = completion
        }
        
        func dupeComplete(with error: Error?,
                          file: StaticString = #filePath,
                          line: UInt = #line) {
            
            guard let dupeCompletion = dupeCompletion else {
                return XCTFail("Request never made", file: file, line: line)
            }
            
            dupeCompletion(error)
        }
        
        func finishedComplete(with error: Error?,
                              file: StaticString = #filePath,
                              line: UInt = #line) {
            
            guard let finishedCompletion = finishedCompletion else {
                return XCTFail("Request never made", file: file, line: line)
            }
            
            finishedCompletion(error)
        }
    }
}
