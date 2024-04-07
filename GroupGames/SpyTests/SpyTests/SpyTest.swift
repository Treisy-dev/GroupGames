//
//  SpyTest.swift
//  SpyTest
//
//  Created by surexnx on 07.04.2024.
//

import XCTest
@testable import GroupGames

final class SpyTest: XCTestCase {

    let coordinator = SpyCoordinator(navigationController: UINavigationController())
    let settings = Settings(players: [0: 3], timerInSec: [0: 1])
    lazy var viewModel = SpyGameViewModel(output: nil, settings: settings)

    func test_Availability_Qustions() {
        let vailability = !viewModel.qustions.isEmpty
        XCTAssertTrue(vailability)
    }

    func test_Availability_Setting() {
        XCTAssertNotNil(viewModel.settings)
    }

    func test_Equal_Qustions() {
        let firstQustion = viewModel.qustions.first
        XCTAssertEqual("Вопрос 1", firstQustion)
    }

}
