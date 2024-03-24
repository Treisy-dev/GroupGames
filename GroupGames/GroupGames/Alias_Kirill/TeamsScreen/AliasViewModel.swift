//
//  AliasViewModel.swift
//  GroupGames
//
//  Created by Кирилл Щёлоков on 24.03.2024.
//

import Foundation
import UIKit

final class AliasViewModel: NSObject, UICollectionViewDataSource {
    var defaultTeams = [
        ("Мега Марсиане", UIImage.alien),
        ("Чудесные Лягушки", UIImage.frog)
    ]
    let teamNames = [
        ("Пушистые Панды", UIImage.panda),
        ("Веселые Викинги", UIImage.viking),
        ("Шустрый Шторм", UIImage.storm),
        ("Летающие Лемуры", UIImage.lemur),
        ("Галактические Гепарды", UIImage.cheetan),
        ("Танцующие Тигры", UIImage.tiger),
        ("Радужные Ракеты", UIImage.rocket),
        ("Мега Марсиане", UIImage.alien),
        ("Чудесные Лягушки", UIImage.frog),
        ("Астрономические Акулы", UIImage.shark)
    ]

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return defaultTeams.count + 1
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == defaultTeams.count {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: AliasAddTeamCollectionViewCell.reuseIdentifier,
                for: indexPath)
                    as? AliasAddTeamCollectionViewCell else { return UICollectionViewCell()}
            cell.addTapped = { [weak self] in
                if self?.defaultTeams.count != 10 {
                    guard let newTeam = self?.teamNames[indexPath.item] else { return }
                    self?.defaultTeams.append(newTeam)
                    collectionView.reloadData()
                }
            }
            return cell

        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: AliasTeamsCollectionViewCell.reuseIdentifier,
                for: indexPath)
                    as? AliasTeamsCollectionViewCell else { return UICollectionViewCell()}

            cell.deleteTapped = { [weak self] teamName in
                if self?.defaultTeams.count ?? 0 != 2 {
                    if let index = self?.defaultTeams.firstIndex(where: { $0.0 == teamName }) {
                        self?.defaultTeams.remove(at: index)
                        collectionView.reloadData()
                    }
                }
            }

            cell.config(teamName: defaultTeams[indexPath.item].0, teamImage: defaultTeams[indexPath.item].1)

            return cell
        }
    }
}
