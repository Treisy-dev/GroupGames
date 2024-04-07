//
//  SpyMainViewController.swift
//  GroupGames
//
//  Created by surexnx on 23.03.2024.
//

import UIKit
import SnapKit

enum AccessibilityIdentifiersSpy {
    static let startButton = "startButtonSpy"
    static let exitButton = "exitButtonSpy"
}

final class SpyMainViewController: UIViewController {

    // MARK: Private properties

    private var viewModel: SpyMainViewModel

    private lazy var nameGameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Spy, ну а кто не Spy"
        return label
    }()
    private lazy var startButton: UIButton = {
        let action = UIAction { [weak self] _ in
            self?.viewModel.trigger(.start)
        }
        let button = UIButton(primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Start", for: .normal)
        button.accessibilityIdentifier = AccessibilityIdentifiersSpy.startButton
        return button
    }()

    private lazy var settingsButton: UIButton = {
        let action = UIAction { [weak self] _ in
            self?.viewModel.trigger(.settings)
        }
        let button = UIButton(primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Settings", for: .normal)
        return button
    }()

    private lazy var exitButton: UIButton = {
        let action = UIAction { [weak self] _ in
            self?.viewModel.trigger(.exit)
        }
        let button = UIButton(primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Exit", for: .normal)
        button.accessibilityIdentifier = AccessibilityIdentifiersSpy.exitButton
        return button
    }()

    // MARK: Initializators

    init(viewModel: SpyMainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupButton()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
    }

    // MARK: Private methods

    private func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [startButton, settingsButton, exitButton])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)
        view.addSubview(nameGameLabel)

        nameGameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.centerX.equalToSuperview().inset(40)
        }

        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(50)
            make.centerY.equalToSuperview()
        }
    }

    private func setupButton() {
        exitButton.setTitleColor(.black, for: .normal)
        startButton.setTitleColor(.black, for: .normal)
        settingsButton.setTitleColor(.black, for: .normal)
    }
}
