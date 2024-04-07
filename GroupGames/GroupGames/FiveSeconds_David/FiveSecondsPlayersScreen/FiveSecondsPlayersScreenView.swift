//
//  PlayersScreenView.swift
//  GroupGames
//
//  Created by Давид Васильев on 25.03.2024.
//
import SnapKit
import UIKit
enum AccessibilityIdentifiersFiveSeconds {
    static let addPlayerButtonFiveSeconds = "addPlayerButton"
    static let startButtonFiveSeconds  = "startButton"
    static let exitButtonFiveSeconds  = "exitButton"
    static let contentViewTitleLabelFiveSeconds = "contentViewTitleLabel"
}

class FiveSecondsPlayersScreenView: UIView {

    private lazy var playersContentView: UIView = UIView()
    private lazy var contentViewTitleLabel: UILabel = UILabel()
    lazy var playersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    private lazy var startButton = FiveSecondsGameButtonFabric.shared.makeTransparentButton(title: "Начать игру")
    private lazy var addPlayerButton = FiveSecondsGameButtonFabric.shared.makeTransparentButton(title: "+")
    private lazy var exitButton = FiveSecondsGameButtonFabric.shared.makeExitButton()

    var nextTapped: (() -> Void)?
    var addPlayerTapped: (() -> Void)?
    var exitButtonTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .back
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpContentView()
        setUpContentViewTitleLabel()
        setUpPlayersCollectionView()
        setUpStartButton()
        setUpAddPLayerButton()
        setUpBackground()
        setUpExitButton()
    }

    private func setUpBackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = .backOrange
        backgroundImage.contentMode = .scaleAspectFill
        self.insertSubview(backgroundImage, at: 0)
    }

    private func setUpContentView() {
        addSubview(playersContentView)
        playersContentView.backgroundColor = .clear
        playersContentView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(60)
            make.bottom.equalToSuperview().inset(120)
        }
    }

    private func setUpContentViewTitleLabel() {
        playersContentView.addSubview(contentViewTitleLabel)
        contentViewTitleLabel.text = "Добавьте игроков"
        contentViewTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        contentViewTitleLabel.numberOfLines = 2
        contentViewTitleLabel.textAlignment = .center
        contentViewTitleLabel.textColor = .white
        contentViewTitleLabel.accessibilityIdentifier = AccessibilityIdentifiersFiveSeconds.contentViewTitleLabelFiveSeconds
        contentViewTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(70)
            make.trailing.equalToSuperview().inset(70)
        }
    }

    private func setUpPlayersCollectionView() {
        playersContentView.addSubview(playersCollectionView)
        playersCollectionView.backgroundColor = .clear
        playersCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalTo(contentViewTitleLabel.snp.bottom).offset(30)
            make.bottom.equalToSuperview().inset(20)
        }
    }

    private func setUpStartButton() {
        addSubview(startButton)
        let nextAction: UIAction = UIAction { [weak self] _ in
            self?.nextTapped?()
        }
        startButton.addAction(nextAction, for: .touchUpInside)
        startButton.accessibilityIdentifier = AccessibilityIdentifiersFiveSeconds.startButtonFiveSeconds
        startButton.snp.makeConstraints { make in
            make.top.equalTo(playersContentView.snp.bottom).offset(10)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(50)
            make.leading.equalToSuperview().offset(90)
        }
    }

    private func setUpAddPLayerButton() {
        addSubview(addPlayerButton)
        let optionsAction: UIAction = UIAction { [weak self] _ in
            self?.addPlayerTapped?()
        }
        addPlayerButton.addAction(optionsAction, for: .touchUpInside)
        addPlayerButton.accessibilityIdentifier = AccessibilityIdentifiersFiveSeconds.addPlayerButtonFiveSeconds
        addPlayerButton.snp.makeConstraints { make in
            make.top.equalTo(playersContentView.snp.bottom).offset(10)
            make.trailing.equalTo(startButton.snp.leading).inset(-10)
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().inset(50)
        }
    }

    private func setUpExitButton() {
        addSubview(exitButton)
        let optionsAction: UIAction = UIAction { [weak self] _ in
            self?.exitButtonTapped?()
        }
        exitButton.addAction(optionsAction, for: .touchUpInside)
        exitButton.accessibilityIdentifier = AccessibilityIdentifiersFiveSeconds.exitButtonFiveSeconds
        exitButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(64)
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(40)
        }
    }
}
