//
//  FiveSecondSnapshotTests.swift
//  FiveSecondSnapshotTests
//
//  Created by Кирилл Щёлоков on 07.04.2024.
//

import XCTest
import SnapshotTesting
@testable import GroupGames
final class FiveSecondsGameScreenSnapshotTests: XCTestCase {

    func test_FiveSecondPlayersSnapshot() throws {
        let viewModel = FiveSecondsGameScreenViewModel(namesPlayers: [("Player1", .alien)])
        let controller = FiveSecondsGameScreenViewController(viewModel: viewModel)

        assertSnapshot(of: controller, as: .image)
    }
}
final class FiveSecondSnapshotTests: XCTestCase {

    func test_FiveSecondPlayersSnapshot() throws {
        let viewModel = FiveSecondsPlayersScreenViewModel()
        let controller = FiveSecondsPlayersScreenViewController(viewModel: viewModel)

        assertSnapshot(of: controller, as: .image)
    }
}
