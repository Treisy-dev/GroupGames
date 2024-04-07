//
//  SpyViewModel.swift
//  GroupGames
//
//  Created by surexnx on 23.03.2024.
//

import Foundation
import Combine

enum SpyMainViewIntent {
    case settings
    case start
    case exit
}

final class SpyMainViewModel: ViewModel {

    // MARK: Private properties

    private var output: SpyMainModuleOutput?

    // MARK: Initializators

    init(output: SpyMainModuleOutput?) {
        self.output = output
    }

    // MARK: Internal methods

    func trigger(_ itent: SpyMainViewIntent) {
        switch itent {
        case .settings:
            output?.proccedButtonTapedSettings()
        case .start:
            output?.proccedButtonTapedStart()
        case .exit:
            output?.proccedButtonTapedExit()
        }
    }
}
