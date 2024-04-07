//
//  SpyUITest.swift
//  SpyUITest
//
//  Created by surexnx on 07.04.2024.
//

import XCTest

final class SpyUITest: XCTestCase {

    let app = XCUIApplication()

    func testStartButton() throws {
        let startButton = app.buttons["startButtonSpy"]
        XCTAssertFalse(startButton.exists)
    }

    func testExitButton() throws {
        let exitButton = app.buttons["exitButtonSpy"]
        XCTAssertFalse(exitButton.exists)
    }
}

