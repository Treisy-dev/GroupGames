//
//  SpyGameViewBuilder.swift
//  GroupGames
//
//  Created by surexnx on 24.03.2024.
//

import Foundation
import UIKit

final class SpyGameViewBuilder {

    // MARK: Private properties

    private let output: SpyGameModuleOutput
    private let settings: Settings

    // MARK: Initializators

    init(output: SpyGameModuleOutput, settings: Settings) {
        self.output = output
        self.settings = settings
    }

    // MARK: Internal properties

    func build() -> UIViewController {
        let viewModel = SpyGameViewModel(output: output, settings: settings)
        let controller = SpyGameViewController(viewModel: viewModel)
        return controller
    }
}
