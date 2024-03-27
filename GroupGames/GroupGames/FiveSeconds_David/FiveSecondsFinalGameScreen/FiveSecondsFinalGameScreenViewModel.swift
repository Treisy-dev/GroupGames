//
//  FiveSecondsFinalGameScreenViewModel.swift
//  GroupGames
//
//  Created by Давид Васильев on 27.03.2024.
//

import UIKit
final class FiveSecondsFinalGameScreenViewModel: NSObject {

    var playerName: String
    var scores: Int

    init(playerName: String, scores: Int) {
        self.playerName = playerName
        self.scores = scores
    }
    func getPlayer() -> String {
        return playerName
    }

    func getScores() -> Int {
        return scores
    }
}
