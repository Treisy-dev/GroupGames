//
//  GameScreenViewController.swift
//  GroupGames
//
//  Created by Давид Васильев on 24.03.2024.
//

import UIKit
import Koloda

class FiveSecondsGameScreenViewController: UIViewController {

    private let gameScreenView: FiveSecondsGameScreenView = FiveSecondsGameScreenView()
    private let viewModel: FiveSecondsGameScreenViewModel

    init(viewModel: FiveSecondsGameScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.gameScreenView.kolodaView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        gameScreenView.kolodaView.dataSource = viewModel
        gameScreenView.scoresCollectionView.dataSource = viewModel
        gameScreenView.scoresCollectionView.delegate = self

        gameScreenView.timerDidFinishClosure = {
            if let currentCard = self.gameScreenView.kolodaView.viewForCard(
                at: self.gameScreenView.kolodaView.currentCardIndex) as? FiveSecondsCardView {
                currentCard.setFinalText()
            }
        }

        gameScreenView.checkTaskTappedClosure = {
            let curentCardIndex = self.gameScreenView.kolodaView.currentCardIndex % self.viewModel.namesPlayers.count
            if let currentCard = self.gameScreenView.kolodaView.viewForCard(at:
                self.gameScreenView.kolodaView.currentCardIndex) as? FiveSecondsCardView {
                currentCard.configure(
                    name: self.viewModel.namesPlayers[curentCardIndex].0,
                    task: self.viewModel.tasks[self.gameScreenView.kolodaView.currentCardIndex])
                self.gameScreenView.startTimer()
            }
        }

        gameScreenView.scoresCollectionView.register(
            FiveSecondsScoresCollectionViewCell.self,
            forCellWithReuseIdentifier: FiveSecondsScoresCollectionViewCell.reuseIdentifier)

        gameScreenView.exitButtonTapped = {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = gameScreenView
    }
}

extension FiveSecondsGameScreenViewController: KolodaViewDelegate, UICollectionViewDelegate {

    func koloda(_ koloda: KolodaView, allowedDirectionsForIndex index: Int) -> [SwipeResultDirection] {
        return [.left, .right]
    }

    func vibrate() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error) // Можно использовать .success, .warning или .error для различных типов вибрации
        generator.prepare()
    }

    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        if direction == .right {
            gameScreenView.stopTimer()
            gameScreenView.unHiddenCheckButton()
            viewModel.addScore(bol: true)
            guard let card = gameScreenView.scoresCollectionView.cellForItem(
                at: IndexPath(
                    row: index % viewModel.namesPlayers.count, section: 0))
                    as? FiveSecondsScoresCollectionViewCell else {return}
            guard let score = card.scoreLabel.text else {return}
            guard let intScore = Int(score) else {return}
            card.scoreLabel.text = String(intScore + 1)
        } else if direction == .left {
            gameScreenView.startAnimation()
            vibrate()
            gameScreenView.stopTimer()
            gameScreenView.unHiddenCheckButton()
            viewModel.addScore(bol: false)
        }
        if self.gameScreenView.kolodaView.currentCardIndex == self.gameScreenView.kolodaView.countOfCards {
            if let bestPlayer = viewModel.scoresPlayers.max(by: { $0.1 < $1.1 }) {
                self.navigationController?.pushViewController(
                    FiveSecondsFinalGameScreenViewController(
                        viewModel: FiveSecondsFinalGameScreenViewModel(playerName: bestPlayer.0, scores: bestPlayer.1)), animated: true)
            }
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = 100.0
            let height = 100.0
            return CGSize(width: width, height: height)
    }
}
