//
//  SpySettingsViewController.swift
//  GroupGames
//
//  Created by surexnx on 23.03.2024.
//

import UIKit
import SnapKit

class SpySettingsViewController: UIViewController {

    // MARK: Private properties

    private var viewModel: SpySettingsViewModel

    private lazy var playersSegmentControl: UISegmentedControl = {
        let playersSetting = viewModel.playersSettingSC
        let segmentControl = UISegmentedControl(items: playersSetting)
        segmentControl.addTarget(self, action: #selector(playersSegmentedControlValueChanged(_:)), for: .valueChanged)
        return segmentControl
    }()
    private lazy var timerSegmentControl: UISegmentedControl = {
        let playersSetting = viewModel.timerSettingSC
        let segmentControl = UISegmentedControl(items: playersSetting)
        segmentControl.addTarget(self, action: #selector(timersSegmentedControlValueChanged(_:)), for: .valueChanged)
        return segmentControl
    }()
    private lazy var playersLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.text = "Players:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var timerLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.text = "Time:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: Initializator

    init(viewModel: SpySettingsViewModel) {
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
        setupSettings()
        view.backgroundColor = .white
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.trigger(.onClose)
    }

    // MARK: Private methods

    private func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [playersSegmentControl, timerSegmentControl])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        let labelstackView = UIStackView(arrangedSubviews: [playersLabel, timerLabel])
        labelstackView.axis = .vertical
        labelstackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelstackView)

        stackView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()}

        labelstackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(stackView).inset(100)
        }
    }

    private func setupSettings() {
        let settings = viewModel.settings
        if let (key, _) = settings.players.first {
            self.playersSegmentControl.selectedSegmentIndex = key
        }
        if let (key, _) = settings.timerInSec.first {
            self.timerSegmentControl.selectedSegmentIndex = key
        }
    }
    @objc private func playersSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        var players: [Int: Int] = [:]
        switch playersSegmentControl.selectedSegmentIndex {
        case 0:
            players = [0: 3]
        case 1:
            players = [1: 4]
        case 2:
            players = [2: 5]
        default:
            players = [0: 3]
        }
        viewModel.settings.players = players
    }
    @objc private func timersSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        var timer: [Int: Int] = [:]
        switch timerSegmentControl.selectedSegmentIndex {
        case 0:
            timer = [0: 60]
        case 1:
            timer = [1: 120]
        case 2:
            timer = [2: 180]
        default:
            timer = [0: 60]
        }
        viewModel.settings.timerInSec = timer
    }
}
