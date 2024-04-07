//
//  AliasSnapshotTests.swift
//  AliasSnapshotTests
//
//  Created by Кирилл Щёлоков on 07.04.2024.
//

import XCTest
import SnapshotTesting
@testable import GroupGames

final class AliasSnapshotTests: XCTestCase {

    func test_aliasTeamsViewController_rendersCorrectly() {
        let aliasTeamsVC = AliasTeamsViewController(viewModel: AliasTeamsViewModel())
        assertSnapshot(matching: aliasTeamsVC, as: .image)
    }

    func test_aliasScoreViewController_rendersCorrectly() {
        let defaultTeams = [
            ("Мега Марсиане", UIImage.alien, UIColor.systemRed.withAlphaComponent(0.5)),
            ("Чудесные Лягушки", UIImage.frog, UIColor.systemGreen.withAlphaComponent(0.5))
        ]
        let aliasScoreVC = AliasScoreViewController(viewModel: AliasScoreViewModel(defaultTeams: defaultTeams))
        assertSnapshot(matching: aliasScoreVC, as: .image)
    }
}
