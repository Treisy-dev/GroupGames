//
//  SpyUITest.swift
//  SpyUITest
//
//  Created by surexnx on 07.04.2024.
//

import XCTest

final class SpyUITest: XCTestCase {

    private var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        let backButton = app.buttons["spyButton"]
        backButton.tap()
    }

    func testStartButton() throws {
        let startButton = app.buttons["startButtonSpy"]
        XCTAssertTrue(startButton.exists)
    }

    func testExitButton() throws {
        let exitButton = app.buttons["exitButtonSpy"]
        XCTAssertTrue(exitButton.exists)
    }
}

