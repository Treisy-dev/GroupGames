//
//  FiveSecondsFinalGameScreenView.swift
//  GroupGames
//
//  Created by Давид Васильев on 27.03.2024.
//

import UIKit

class FiveSecondsFinalGameScreenView: UIView {

    private lazy var resultLabel: UILabel = UILabel()
    private lazy var playerNameLabel: UILabel = UILabel()
    private lazy var exitButton = FiveSecondsGameButtonFabric.shared.makeExitButton()

    var exitButtonTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func config(resultText: Int, playerNameText: String) {
        resultLabel.text = "\(resultText)"
        playerNameLabel.text = playerNameText
    }

    private func setUp() {
        setUpBackground()
        setUpExitButton()
        setUpResultLabel()
        setUpPlayerNameLabel()
    }

    private func setUpBackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = .backOrange
        backgroundImage.contentMode = .scaleAspectFill
        self.insertSubview(backgroundImage, at: 0)
    }

    private func setUpExitButton() {
        addSubview(exitButton)
        let optionsAction: UIAction = UIAction { [weak self] _ in
            self?.exitButtonTapped?()
        }
        exitButton.addAction(optionsAction, for: .touchUpInside)
        exitButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(64)
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(40)
        }
    }

    private func setUpResultLabel() {
        addSubview(resultLabel)
        resultLabel.font = UIFont.boldSystemFont(ofSize: 56.0)
        resultLabel.textAlignment = .center
        resultLabel.minimumScaleFactor = 0.5
        resultLabel.adjustsFontSizeToFitWidth = true
        resultLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(180)
            make.width.equalTo(140)
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
        }
    }

    private func setUpPlayerNameLabel() {
        addSubview(playerNameLabel)
        playerNameLabel.font = UIFont.boldSystemFont(ofSize: 56.0)
        playerNameLabel.textAlignment = .center
        playerNameLabel.minimumScaleFactor = 0.5
        playerNameLabel.adjustsFontSizeToFitWidth = true
        playerNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(280)
            make.width.equalTo(140)
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
        }
    }
}
