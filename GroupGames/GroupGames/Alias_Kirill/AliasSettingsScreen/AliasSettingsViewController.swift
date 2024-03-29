//
//  SettingsViewController.swift
//  GroupGames
//
//  Created by Кирилл Щёлоков on 24.03.2024.
//

import UIKit

class AliasSettingsViewController: UIViewController {

    private let contentView: AliasSettingsView = .init()

    private let viewModel: AliasSettingsViewModel

    init(viewModel: AliasSettingsViewModel) {
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
        guard let duration = (contentView.durationSegmentControl.titleForSegment(at: contentView.durationSegmentControl.selectedSegmentIndex))
            else { return }
        guard let points = (contentView.pointsSegmentControl.titleForSegment(at: contentView.pointsSegmentControl.selectedSegmentIndex))
            else { return }
        viewModel.saveSettingsInfo(duration: duration, winPoints: points)
    }

}
