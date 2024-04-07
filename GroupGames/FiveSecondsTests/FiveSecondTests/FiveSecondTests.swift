//
//  FiveSecondTests.swift
//  FiveSecondTests
//
//  Created by Кирилл Щёлоков on 07.04.2024.
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

final class FiveSecondsGameScreenViewModelTests: XCTestCase {

    var viewModel: FiveSecondsGameScreenViewModel!

    override func setUpWithError() throws {
        viewModel = FiveSecondsGameScreenViewModel(namesPlayers: [("Player1", UIImage()), ("Player2", UIImage())])
    }

    func testAddScore() {
        // Given
        let currentPlayerScoreBefore = viewModel.currentPlayerScore

        // When
        viewModel.addScore(flag: true)

        // Then
        XCTAssertEqual(viewModel.scoresPlayers[viewModel.namesPlayers[currentPlayerScoreBefore].0], 1)
        XCTAssertEqual(viewModel.currentPlayerScore, (currentPlayerScoreBefore + 1) % viewModel.namesPlayers.count)
    }
}

final class FiveSecondsPlayersScreenViewModelTests: XCTestCase {

    var viewModel: FiveSecondsPlayersScreenViewModel!

    override func setUpWithError() throws {
        viewModel = FiveSecondsPlayersScreenViewModel()
    }

    func test_Player_Addition() {
        // Given

        let initialCount = viewModel.firstsPlayers.count

        // When
        viewModel.addPlayer()

        // Then
        XCTAssertEqual(viewModel.firstsPlayers.count, initialCount + 1)
    }
}
