//
//  FiveSecondsFinalGamesScreenViewModelTests.swift
//  FiveSecondsFinalGamesScreenViewModelTests
//
//  Created by Давид Васильев on 07.04.2024.
//

import XCTest
@testable import GroupGames
final class FiveSecondsFinalGamesScreenViewModelTests: XCTestCase {

    var viewModel: FiveSecondsFinalGameScreenViewModel!

    override func setUpWithError() throws {
        viewModel = FiveSecondsFinalGameScreenViewModel(playerName: "Alice", scores: 100)
    }

    func testGetPlayer() {
        XCTAssertEqual(viewModel.getPlayer(), "Alice")
    }

    func testGetScores() {
        XCTAssertEqual(viewModel.getScores(), 100)
    }
}
