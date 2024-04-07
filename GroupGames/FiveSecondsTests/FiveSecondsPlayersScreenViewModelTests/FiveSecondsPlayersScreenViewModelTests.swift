//
//  FiveSecondsPlayersScreenViewModelTests.swift
//  FiveSecondsPlayersScreenViewModelTests
//
//  Created by Давид Васильев on 07.04.2024.
//

import XCTest
@testable import GroupGames
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
