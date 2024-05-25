//
//  AliasScoreViewModelSUI.swift
//  GroupGames
//
//  Created by Кирилл Щёлоков on 25.05.2024.
//

import SwiftUI

class AliasScoreViewModelSUI: ObservableObject {
    @Published var defaultTeams: [(String, UIImage, UIColor, String)] = []

    init(defaultTeams: [(String, UIImage, UIColor)]) {
        self.defaultTeams = defaultTeams.map { ($0.0, $0.1, $0.2, "0") }
    }
}
