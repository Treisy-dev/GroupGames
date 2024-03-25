//
//  AliasViewModel.swift
//  GroupGames
//
//  Created by Кирилл Щёлоков on 24.03.2024.
//

import UIKit

final class TeamsViewModel: NSObject, UICollectionViewDataSource {
    private let userDefaultsDataManager = UserDefaultsDataManager.shared

    var defaultTeams = [
        ("Мега Марсиане", UIImage.alien, UIColor.systemRed.withAlphaComponent(0.5)),
        ("Чудесные Лягушки", UIImage.frog, UIColor.systemGreen.withAlphaComponent(0.5))
    ]
    let teamNames = [
        ("Пушистые Панды", UIImage.panda, UIColor.systemGray.withAlphaComponent(0.5)),
        ("Веселые Викинги", UIImage.viking, UIColor.systemMint.withAlphaComponent(0.5)),
        ("Шустрый Шторм", UIImage.storm, UIColor.systemPink.withAlphaComponent(0.5)),
        ("Летающие Лемуры", UIImage.lemur, UIColor.systemBrown.withAlphaComponent(0.5)),
        ("Галактические Гепарды", UIImage.cheetan, UIColor.systemYellow.withAlphaComponent(0.5)),
        ("Танцующие Тигры", UIImage.tiger, UIColor.systemOrange.withAlphaComponent(0.5)),
        ("Радужные Ракеты", UIImage.rocket, UIColor.systemTeal.withAlphaComponent(0.5))
    ]

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return defaultTeams.count + 1
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == defaultTeams.count {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TeamsAddCollectionViewCell.reuseIdentifier,
                for: indexPath)
                    as? TeamsAddCollectionViewCell else { return UICollectionViewCell()}
            cell.addTapped = { [weak self] in
                if self?.defaultTeams.count != 7 {
                    guard let newTeam = self?.teamNames[indexPath.row] else { return }
                    self?.defaultTeams.append(newTeam)
                    collectionView.reloadData()
                }
            }
            return cell

        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TeamsCollectionViewCell.reuseIdentifier,
                for: indexPath)
                    as? TeamsCollectionViewCell else { return UICollectionViewCell()}

            cell.deleteTapped = { [weak self] teamName in
                if self?.defaultTeams.count ?? 0 != 2 {
                    if let index = self?.defaultTeams.firstIndex(where: { $0.0 == teamName }) {
                        self?.defaultTeams.remove(at: index)
                        collectionView.reloadData()
                    }
                }
            }

            cell.config(
                teamName: defaultTeams[indexPath.item].0,
                teamImage: defaultTeams[indexPath.item].1,
                backgroundColor: defaultTeams[indexPath.item].2)

            return cell
        }
    }

    func updateSettingsInfo() {
        userDefaultsDataManager.updateSettingsData()
    }
}
