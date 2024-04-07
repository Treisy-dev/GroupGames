//
//  AliasTest.swift
//  AliasTest
//
//  Created by Кирилл Щёлоков on 07.04.2024.
//

import XCTest
@testable import GroupGames

final class AliasTest: XCTestCase {

    private var dataManager: AliasUserDefaultsDataManager!

    override func setUpWithError() throws {
        dataManager = AliasUserDefaultsDataManager.shared
        dataManager.userDefaults.removeObject(forKey: "settingsInfo")
    }

    override func tearDownWithError() throws {
        dataManager.userDefaults.removeObject(forKey: "settingsInfo")
    }

    func testUpdateSettingsData_WhenNoDataExists_CreatesDefaultSettings() {
        dataManager.updateSettingsData()

        let settings = dataManager.getSettingsData()
        XCTAssertEqual(settings["duration"], "30")
        XCTAssertEqual(settings["winPoints"], "25")
    }

    func testUpdateSettingsData_WhenDataExists_PrintsExistingData() {
        let mockData = ["duration": "45", "winPoints": "30"]
        dataManager.userDefaults.set(mockData, forKey: "settingsInfo")
        let obtainedData = dataManager.getSettingsData()

        XCTAssertEqual(mockData["duration"], obtainedData["duration"])
        XCTAssertEqual(mockData["winPoints"], obtainedData["winPoints"])
    }

    func testGetDuration_WhenNoDataExists_ReturnsDefaultDuration() {
        XCTAssertEqual(dataManager.getDuration(), 30)
    }

    func testGetDuration_WhenValidDataExists_ReturnsParsedInt() {
        let mockData = ["duration": "60"]
        dataManager.userDefaults.set(mockData, forKey: "settingsInfo")

        XCTAssertEqual(dataManager.getDuration(), 60)
    }

    func testGetWinPoints_WhenNoDataExists_ReturnsDefaultWinPoints() {
        XCTAssertEqual(dataManager.getWinPoints(), 25)
    }

    func testGetWinPoints_WhenValidDataExists_ReturnsParsedInt() {
        let mockData = ["winPoints": "40"]
        dataManager.userDefaults.set(mockData, forKey: "settingsInfo")

        XCTAssertEqual(dataManager.getWinPoints(), 40)
    }
}
