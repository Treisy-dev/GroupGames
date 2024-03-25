//
//  MainViewController.swift
//  GroupGames
//
//  Created by Кирилл Щёлоков on 11.03.2024.
//

import UIKit

final class MainViewController: UIViewController {

    private let contentView: MainView = .init()

    private let viewModel: MainViewModel

    init(viewModel: MainViewModel) {
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
        contentView.delegate = self
    }
}

extension MainViewController: MainViewDelegate {
    func didYesNoButtonTapped() {
        print(1)
    }
    
    func didAliasButtonTapped() {
        navigationController?.pushViewController(TeamsViewController(viewModel: TeamsViewModel()), animated: true)
    }
    
    func didSpyButtonTapped() {
        guard let navigationController = navigationController else { return }
        let spyCoordinator = SpyCoordinator(navigationController: navigationController)
        spyCoordinator.start()
        print(3)
        
    }
}
