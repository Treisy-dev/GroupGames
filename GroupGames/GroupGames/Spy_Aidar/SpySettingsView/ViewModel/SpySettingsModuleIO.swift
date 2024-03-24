//
//  SpySettingsModelIO.swift
//  GroupGames
//
//  Created by surexnx on 23.03.2024.
//

import Foundation

protocol SpySettingsModuleInput: AnyObject {}

protocol SpySettingsModuleOutput: AnyObject {
    func moduleWantsToClose(_ settings: Settings)
}
