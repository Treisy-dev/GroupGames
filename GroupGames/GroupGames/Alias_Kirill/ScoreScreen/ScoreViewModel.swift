//
//  ScoreViewModel.swift
//  GroupGames
//
//  Created by Кирилл Щёлоков on 24.03.2024.
//

import Foundation
import UIKit
class ScoreViewModel: NSObject, UITableViewDataSource {
    var defaultTeams: [(String, UIImage, UIColor)]

    init(defaultTeams: [(String, UIImage, UIColor)]) {
        self.defaultTeams = defaultTeams
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        defaultTeams.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TeamTableViewCell(style: .default, reuseIdentifier: nil)
        cell.config(
            teamName: defaultTeams[indexPath.row].0,
            teamImage: defaultTeams[indexPath.row].1,
            backgroundColor: defaultTeams[indexPath.row].2)
        return cell
    }
}
