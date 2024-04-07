//
//  SpySnapshotTests.swift
//  AliasTest
//
//  Created by surexnx on 07.04.2024.
//

import XCTest
import SnapshotTesting

@testable import GroupGames

final class SpySnapshotTests: XCTestCase {

    func testSpyMainView() throws {
        let controller = SpyMainViewBuilder(output: nil).build()
        assertSnapshot(of: controller, as: .image)
    }

    func testSettingView() throws {
        let settings = Settings(players: [0: 3], timerInSec: [0: 1])
        let controller = SpyGameViewBuilder(output: nil, settings: settings).build()
        assertSnapshot(of: controller, as: .image)
    }

}
