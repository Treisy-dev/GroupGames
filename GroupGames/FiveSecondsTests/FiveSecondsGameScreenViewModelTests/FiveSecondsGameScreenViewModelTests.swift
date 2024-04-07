//
//  FiveSecondTests.swift
//  FiveSecondTests
//
//  Created by Кирилл Щёлоков on 07.04.2024.
//

import XCTest
@testable import GroupGames
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
