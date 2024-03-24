//
//  AliasViewController.swift
//  GroupGames
//
//  Created by Кирилл Щёлоков on 24.03.2024.
//

import UIKit

final class AliasViewController: UIViewController {

    private let contentView: AliasView = .init()

    private let viewModel: AliasViewModel

    init(viewModel: AliasViewModel) {
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
            AliasTeamsCollectionViewCell.self,
            forCellWithReuseIdentifier: AliasTeamsCollectionViewCell.reuseIdentifier)

        contentView.teamsCollectionView.register(
            AliasAddTeamCollectionViewCell.self,
            forCellWithReuseIdentifier: AliasAddTeamCollectionViewCell.reuseIdentifier)

        contentView.optionsTapped = {[weak self] in
            self?.navigationController?.present(SettingsViewController(viewModel: SettingsViewModel()), animated: true)
        }
    }
}
extension AliasViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = collectionView.frame.width / 2 - 20
            let height = 156.0
            return CGSize(width: width, height: height)
        }
}
