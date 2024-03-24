//
//  SpySettingsViewBuilder.swift
//  GroupGames
//
//  Created by surexnx on 23.03.2024.
//

import Foundation
import UIKit

final class SpySettingsViewBuilder {

    // MARK: Private properties

    private let output: SpySettingsModuleOutput
    private let settings: Settings

    // MARK: Initializators

    init(output: SpySettingsModuleOutput, settings: Settings) {
        self.output = output
        self.settings = settings
    }

    // MARK: Internal properties

    func build() -> UIViewController {
        let viewModel = SpySettingsViewModel(output: output, settings: settings)
        let controller = SpySettingsViewController(viewModel: viewModel)
        return controller
    }
}
