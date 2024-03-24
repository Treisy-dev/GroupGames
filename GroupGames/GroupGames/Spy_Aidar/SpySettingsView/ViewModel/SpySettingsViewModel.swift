//
//  SpySettingsViewModel.swift
//  GroupGames
//
//  Created by surexnx on 23.03.2024.
//

import Foundation
import Combine

enum SpySettingsViewIntent {
    case onClose
}

final class SpySettingsViewModel: ViewModel {

    // MARK: Private properties
        private(set) var playersSettingSC = ["3", "4", "5"]
    private(set) var timerSettingSC  = ["1", "2", "3"]
    private var output: SpySettingsModuleOutput

    // MARK: Internal properties

    var settings: Settings

    // MARK: Initializators

    init(output: SpySettingsModuleOutput, settings: Settings) {
        self.output = output
        self.settings = settings
    }

    // MARK: Internal methods

    func trigger(_ itent: SpySettingsViewIntent) {
        switch itent {
        case .onClose:
            output.moduleWantsToClose(settings)
        }
    }
}
