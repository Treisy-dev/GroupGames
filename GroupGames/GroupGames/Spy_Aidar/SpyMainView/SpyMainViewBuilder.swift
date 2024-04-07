//
//  SpyMainViewBuilder.swift
//  GroupGames
//
//  Created by surexnx on 23.03.2024.
//

import Foundation
import UIKit

final class SpyMainViewBuilder {

    // MARK: Private properties

    private let output: SpyMainModuleOutput?

    // MARK: Initializators

    init(output: SpyMainModuleOutput?) {
        self.output = output
    }

    // MARK: Internal properties

    func build() -> UIViewController {
        let viewModel = SpyMainViewModel(output: output)
        let controller = SpyMainViewController(viewModel: viewModel)
        return controller
    }
}
