//
//  WelcomeRootViewTests.swift
//  
//
//  Created by Nikolai Nobadi on 2/15/22.
//

import XCTest
import TestHelpers
@testable import WelcomeUI

final class WelcomeRootViewTests: XCTestCase {
    
    func test_configSettings() {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.detailsLabel.text, "details")
        XCTAssertEqual(sut.usernameField.alpha, 1)
    }
    
    func test_okayButton() {
        let exp = expectation(description: "waiting for ...")
        let sut = makeSUT { exp.fulfill() }
        
        sut.okayButton.sendActions(for: [.touchUpInside])
        
        waitForExpectations(timeout: 0.1)
    }
}


// MARK: - SUT
extension WelcomeRootViewTests {
    
    func makeSUT(finished: @escaping () -> Void = { },
                 file: StaticString = #filePath, line: UInt = #line) -> WelcomeRootView {
        
        let sut = WelcomeRootView(config: WelcomeViewInfo(),
                                  finished: finished)

        trackForMemoryLeaks(sut, file: file, line: line)
        
        return sut
    }
}

