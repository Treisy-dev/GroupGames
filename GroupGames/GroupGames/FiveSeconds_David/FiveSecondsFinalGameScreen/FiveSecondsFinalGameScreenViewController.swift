//
//  FiveSecondsFinalGameScreenViewController.swift
//  GroupGames
//
//  Created by Давид Васильев on 27.03.2024.
//

import UIKit

class FiveSecondsFinalGameScreenViewController: UIViewController {

    private let contentView: FiveSecondsFinalGameScreenView = .init()

    private let viewModel: FiveSecondsFinalGameScreenViewModel

    var exitClosure: (() -> Void)?
    init(viewModel: FiveSecondsFinalGameScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
        contentView.config(resultText: viewModel.getScores(), playerNameText: viewModel.getPlayer())
    }

    override func viewDidLoad() {
        contentView.exitButtonTapped = {[weak self] in
            self?.dismiss(animated: true, completion: {
                self?.exitClosure?()
            })
        }
    }
}
