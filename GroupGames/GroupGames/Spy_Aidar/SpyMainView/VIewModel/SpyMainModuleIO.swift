//
//  SpyMainModuleIO.swift
//  GroupGames
//
//  Created by surexnx on 23.03.2024.
//

import Foundation

protocol SpyMainModuleInput: AnyObject {
}
protocol SpyMainModuleOutput: AnyObject {
    func proccedButtonTapedSettings()
    func proccedButtonTapedExit()
    func proccedButtonTapedStart()

}
