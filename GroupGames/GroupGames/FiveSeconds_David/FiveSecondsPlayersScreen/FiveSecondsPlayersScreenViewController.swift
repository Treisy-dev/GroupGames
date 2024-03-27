//
//  PlayersScreenViewController.swift
//  GroupGames
//
//  Created by Давид Васильев on 25.03.2024.
//

import UIKit

class FiveSecondsPlayersScreenViewController: UIViewController {

    private let contentView: FiveSecondsPlayersScreenView = .init()

    private let viewModel: FiveSecondsPlayersScreenViewModel

    init(viewModel: FiveSecondsPlayersScreenViewModel) {
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
        contentView.playersCollectionView.delegate = self
        contentView.playersCollectionView.dataSource = viewModel
        contentView.playersCollectionView.register(
            FiveSecondsPlayersCollectionViewCell.self,
            forCellWithReuseIdentifier: FiveSecondsPlayersCollectionViewCell.reuseIdentifier)
        contentView.nextTapped = {[weak self] in
            self?.navigationController?.pushViewController(
                FiveSecondsGameScreenViewController(
                    viewModel: FiveSecondsGameScreenViewModel(namesPlayers: self?.viewModel.firstsPlayers)), animated: true)
        }
        contentView.addPlayerTapped = {[weak self] in
            self?.viewModel.addPlayer()
            self?.contentView.playersCollectionView.reloadData()
        }
        contentView.exitButtonTapped = {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
}

extension FiveSecondsPlayersScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = collectionView.frame.width
            let height = 66.0
            return CGSize(width: width, height: height)
        }
}
