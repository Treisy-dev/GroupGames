//
//  SettingsViewController.swift
//  GroupGames
//
//  Created by Кирилл Щёлоков on 24.03.2024.
//

import UIKit

class SettingsViewController: UIViewController {

    private let contentView: SettingsView = .init()

    private let viewModel: SettingsViewModel

    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }

}
