//
//  FiveSecondsUITests.swift
//  FiveSecondsUITests
//
//  Created by Кирилл Щёлоков on 07.04.2024.
//

import XCTest

final class FiveSecondsUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        let currentGameButton = app.buttons["yesNoButton"]
        currentGameButton.tap()
    }

    func test_startGameButton() throws {
        let startButton = app.buttons["startButton"]
        XCTAssertTrue(startButton.exists)
    }

    func test_exitButton() throws {
        let backButton = app.buttons["exitButton"]
        XCTAssertTrue(backButton.exists)
    }

    func test_addPlayerButton() throws {
        let addPlayerButton = app.buttons["addPlayerButton"]
        XCTAssertTrue(addPlayerButton.exists)
    }

    func test_ContentViewTitle() throws {
        let contentViewTitleLabel = app.staticTexts["contentViewTitleLabel"]
        XCTAssertTrue(contentViewTitleLabel.exists)
        XCTAssertEqual(contentViewTitleLabel.label, "Добавьте игроков")
    }
}
