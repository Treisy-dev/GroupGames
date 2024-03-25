//
//  PlayersScreenViewModel.swift
//  GroupGames
//
//  Created by Давид Васильев on 25.03.2024.
//

import UIKit

final class FiveSecondsPlayersScreenViewModel: NSObject, UICollectionViewDataSource {

    private var countPlayers = 2

    var firstsPlayers = [
        ("Чудик", UIImage.alien),
        ("Царевна", UIImage.frog)
    ]

    let playersNames = [
        ("Каратэ Пацан", UIImage.panda),
        ("Батя", UIImage.viking),
        ("Тучка", UIImage.storm),
        ("Джулиан", UIImage.lemur),
        ("Кот", UIImage.cheetan),
        ("Мой братан", UIImage.tiger),
        ("Ракета", UIImage.rocket),
        ("Акула", UIImage.shark)
    ]

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return firstsPlayers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FiveSecondsPlayersCollectionViewCell.reuseIdentifier, for: indexPath)
                as? FiveSecondsPlayersCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.deleteTapped = { [weak self] teamName in
            if self?.firstsPlayers.count ?? 0 != 2 {
                self?.countPlayers -= 1
                if let index = self?.firstsPlayers.firstIndex(where: { $0.0 == teamName }) {
                    self?.firstsPlayers.remove(at: index)
                    collectionView.reloadData()
                }
            }
        }

        cell.config(teamName: firstsPlayers[indexPath.item].0, teamImage: firstsPlayers[indexPath.item].1)

        return cell
    }

    func addPlayer() {
        if countPlayers < 7 {
            firstsPlayers.append(playersNames[countPlayers - 2])
            countPlayers += 1
        }
    }
}
