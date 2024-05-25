//
//  GameViewController.swift
//  GroupGames
//
//  Created by Кирилл Щёлоков on 24.03.2024.
//
import Koloda
import UIKit

class AliasGameViewController: UIViewController {

    private let contentView: AliasGameView = .init()
    weak var delegate: AliasGameDelegate?
    weak var viewModelSUI: AliasScoreViewModelSUI?
    let viewModel: AliasGameViewModel
    var onDismiss: (() -> Void)?

    init(viewModel: AliasGameViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        onDismiss?()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.kolodaView.dataSource = viewModel
        contentView.kolodaView.delegate = self
        contentView.timerFinished = { [weak self] in
//            self?.delegate?.updateScore(with: self?.viewModel.points ?? 0)
            self?.dismiss(animated: true)
        }
    }
}

extension AliasGameViewController: KolodaViewDelegate {

    func koloda(_ koloda: KolodaView, allowedDirectionsForIndex index: Int) -> [SwipeResultDirection] {
        return [.left, .right]
    }

    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        if direction == .right {
            viewModel.addPoint()
        }
    }
}
