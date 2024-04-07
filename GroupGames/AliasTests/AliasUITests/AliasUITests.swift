//
//  AliasUITests.swift
//  AliasUITests
//
//  Created by Кирилл Щёлоков on 07.04.2024.
//

import XCTest

final class AliasUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        let backButton = app.buttons["aliasButton"]
        backButton.tap()
    }

    func testBackButton_isExist() throws {
        let backButton = app.buttons["backButton"]
        XCTAssertTrue(backButton.exists)
    }

    func testStartButton_isExist() throws {
        let startButton = app.buttons["startButton"]
        XCTAssertTrue(startButton.exists)
    }

    func testOptionsButton_isExist() throws {
        let optionsButton = app.buttons["optionButton"]
        XCTAssertTrue(optionsButton.exists)
    }

    func testContentViewTitleLabelText_isExist_and_SetsCorrectText() throws {
        let contentViewTitleLabel = app.staticTexts["contentViewTitleLabel"]
        XCTAssertTrue(contentViewTitleLabel.exists)
        XCTAssertEqual(contentViewTitleLabel.label, "Разделитесь на команды")
    }
}
