//
//  SettingsViewModel.swift
//  GroupGames
//
//  Created by Кирилл Щёлоков on 24.03.2024.
//

import Foundation

final class SettingsViewModel {
    private let userDefaultsDataManager = UserDefaultsDataManager.shared

    func saveSettingsInfo(duration: String, winPoints: String) {
        userDefaultsDataManager.saveSettingsData(duration: duration, winPoints: winPoints)
    }
}
