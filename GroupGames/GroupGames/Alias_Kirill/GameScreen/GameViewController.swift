//
//  GameViewController.swift
//  GroupGames
//
//  Created by Кирилл Щёлоков on 24.03.2024.
//
import Koloda
import UIKit

class GameViewController: UIViewController {

    private let contentView: GameView = .init()
    weak var delegate: GameDelegate?
    private let viewModel: GameViewModel

    init(viewModel: GameViewModel) {
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
        contentView.kolodaView.dataSource = viewModel
        contentView.kolodaView.delegate = self
        contentView.timerFinished = { [weak self] in
            self?.delegate?.updateScore(with: self?.viewModel.points ?? 0)
            self?.navigationController?.popViewController(animated: true)
        }
    }
}

extension GameViewController: KolodaViewDelegate {

    func koloda(_ koloda: KolodaView, allowedDirectionsForIndex index: Int) -> [SwipeResultDirection] {
        return [.left, .right]
    }

    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        if direction == .right {
            viewModel.addPoint()
        }
    }
}
