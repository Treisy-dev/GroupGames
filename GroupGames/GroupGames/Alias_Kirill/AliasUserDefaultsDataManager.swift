//
//  UserDefaultsDataManager.swift
//  GroupGames
//
//  Created by Кирилл Щёлоков on 24.03.2024.
//

import Foundation

final class AliasUserDefaultsDataManager {
    var settingsDict: [String: String] = ["duration": "", "winPoints": ""]
    let userDefaults = UserDefaults.standard
    public static let shared = AliasUserDefaultsDataManager()

    private init() {
    }

    func saveSettingsData<T: CustomStringConvertible>(duration: T, winPoints: T) {
        settingsDict["duration"] = duration.description
        settingsDict["winPoints"] = winPoints.description
        userDefaults.set(settingsDict, forKey: "settingsInfo")
    }

    func updateSettingsData() {
        if let data = userDefaults.dictionary(forKey: "settingsInfo") {
            print("Данные настройки игры пользователя: \(data)")
        } else {
            settingsDict["duration"] = "30"
            settingsDict["winPoints"] = "25"
            userDefaults.set(settingsDict, forKey: "settingsInfo")
        }
    }

    func getSettingsData() -> [String: String] {
        guard let dict = userDefaults.dictionary(forKey: "settingsInfo") as? [String: String] else { return ["": ""]}
        return dict
    }

    func getDuration() -> Int {
        guard let stringDuration = getSettingsData()["duration"] else { return 30 }
        guard let intDuration = Int(stringDuration) else { return 30 }
        return intDuration
    }

    func getWinPoints() -> Int {
        guard let stringWinPoints = getSettingsData()["winPoints"] else { return 25 }
        guard let intWinPoints = Int(stringWinPoints) else { return 25 }
        return intWinPoints
    }
}
