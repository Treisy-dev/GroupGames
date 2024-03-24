//
//  SpyCoordinator.swift
//  GroupGames
//
//  Created by surexnx on 23.03.2024.
//

import Foundation
import UIKit

final class SpyCoordinator {

    // MARK: Private properties

    private(set) var navigationController: UINavigationController
    private var mainModuleInput: SpyMainModuleInput?
    private var settings: Settings

    // MARK: Initializators

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.settings = Settings(players: [0: 3], timerInSec: [0: 1])
        navigationController.isNavigationBarHidden = true
    }

    // MARK: Internal methods

    func start() {
        showSpyMainView()
    }

    // MARK: Private methods

    private func showSpyGameView() {
        let controller = SpyGameViewBuilder(output: self, settings: settings).build()
        navigationController.pushViewController(controller, animated: false)
    }

    private func showSpyMainView() {
        let controller = SpyMainViewBuilder(output: self).build()
        navigationController.pushViewController(controller, animated: false)
    }

    private func showSpySettingsView() {
        let controller = SpySettingsViewBuilder(output: self, settings: settings).build()
        navigationController.present(controller, animated: true)
    }
}

// MARK: SpyMainModuleOutput

extension SpyCoordinator: SpyMainModuleOutput {
    func proccedButtonTapedSettings() {
        showSpySettingsView()
    }

    func proccedButtonTapedExit() {

    }

    func proccedButtonTapedStart() {
        showSpyGameView()
    }
}

// MARK: SpySettingsModuleOutput

extension SpyCoordinator: SpySettingsModuleOutput {
    func moduleWantsToClose(_ settings: Settings) {
        self.settings = settings
    }
}
// MARK: SpyGameModuleOutput

extension SpyCoordinator: SpyGameModuleOutput {
    func onClouse() {
        showSpyMainView()
    }
}
