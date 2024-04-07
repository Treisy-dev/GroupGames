//
//  GameScreenViewModel.swift
//  GroupGames
//
//  Created by Давид Васильев on 24.03.2024.
//

import UIKit
import Koloda

final class FiveSecondsGameScreenViewModel: NSObject, KolodaViewDataSource, UICollectionViewDataSource {

    var currentPlayerName = 0
    var currentPlayerScore = 0
    var tasks = ["Назовите 5 десертов", "Назовите 3 вида сыра", "Назовите 4 репера", "Назовите 3 острова", "Назовите 5 царей"]
    var namesPlayers: [(String, UIImage)]
    var scoresPlayers: [String: Int]

    init(namesPlayers: [(String, UIImage)]?) {
        self.namesPlayers = namesPlayers ?? []
        scoresPlayers = [:]
        for player in namesPlayers ?? [] {
            scoresPlayers[player.0] = 0
        }
    }

    func koloda(_ koloda: Koloda.KolodaView, viewForCardAt index: Int) -> UIView {
        let card = FiveSecondsCardView()
        swapTurn(to: card)
        return card
    }

    func swapTurn(to card: FiveSecondsCardView) {
        card.configure(name: "Очередь игрока", task: namesPlayers[currentPlayerName].0)
        currentPlayerName = (currentPlayerName + 1) % namesPlayers.count
    }

    func kolodaNumberOfCards(_ koloda: Koloda.KolodaView) -> Int {
        return tasks.count
    }

    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .fast
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return namesPlayers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FiveSecondsScoresCollectionViewCell.reuseIdentifier, for: indexPath)
                as? FiveSecondsScoresCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.config(score: scoresPlayers[namesPlayers[indexPath.item].0] ?? 0, teamImage: namesPlayers[indexPath.item].1)

        return cell
    }

    func addScore(flag: Bool) {
        if flag {
            scoresPlayers[namesPlayers[currentPlayerScore].0]? += 1
        } else {
            print("нет очка")
        }
        currentPlayerScore = (currentPlayerScore + 1) % namesPlayers.count
    }
}
