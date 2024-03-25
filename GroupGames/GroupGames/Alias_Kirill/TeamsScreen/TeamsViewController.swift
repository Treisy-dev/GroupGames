//
//  AliasViewController.swift
//  GroupGames
//
//  Created by Кирилл Щёлоков on 24.03.2024.
//

import UIKit

final class TeamsViewController: UIViewController {

    private let contentView: TeamsView = .init()

    private let viewModel: TeamsViewModel

    init(viewModel: TeamsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.teamsCollectionView.delegate = self
        contentView.teamsCollectionView.dataSource = viewModel
        contentView.teamsCollectionView.register(
            TeamsCollectionViewCell.self,
            forCellWithReuseIdentifier: TeamsCollectionViewCell.reuseIdentifier)

        contentView.teamsCollectionView.register(
            TeamsAddCollectionViewCell.self,
            forCellWithReuseIdentifier: TeamsAddCollectionViewCell.reuseIdentifier)

        contentView.optionsTapped = {[weak self] in
            self?.navigationController?.present(SettingsViewController(viewModel: SettingsViewModel()), animated: true)
        }

        contentView.backTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }

        contentView.nextTapped = { [weak self] in
            self?.viewModel.updateSettingsInfo()
            guard let teams = self?.viewModel.defaultTeams else { return }
            let scoreViewModel = ScoreViewModel(defaultTeams: teams)
            self?.navigationController?.pushViewController(ScoreViewController(viewModel: scoreViewModel), animated: true)
        }
    }
}
extension TeamsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = collectionView.frame.width / 2 - 20
            let height = 156.0
            return CGSize(width: width, height: height)
        }
}
