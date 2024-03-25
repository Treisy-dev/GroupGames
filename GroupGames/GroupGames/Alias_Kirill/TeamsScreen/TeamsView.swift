//
//  AliasView.swift
//  GroupGames
//
//  Created by Кирилл Щёлоков on 24.03.2024.
//
import SnapKit
import UIKit

class TeamsView: UIView {
    private lazy var backButton: UIButton = GameButtonFubric.shared.makeBackButton()
    private lazy var aliasContentView: UIView = UIView()
    private lazy var contentViewTitleLabel: UILabel = UILabel()
    lazy var teamsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    private lazy var startButton: UIButton = GameButtonFubric.shared.makeNextButton(title: "Продолжить")
    private lazy var optionButton: UIButton = UIButton()

    var backTapped: (() -> Void)?
    var nextTapped: (() -> Void)?
    var optionsTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBlue.withAlphaComponent(1.1)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpBackButton()
        setUpContentView()
        setUpContentViewTitleLabel()
        setUpTeamsCollectionView()
        setUpStartButton()
        setUpOptionsButton()
    }

    private func setUpContentView() {
        addSubview(aliasContentView)
        aliasContentView.backgroundColor = .white
        aliasContentView.layer.cornerRadius = 20
        aliasContentView.layer.borderWidth = 3
        aliasContentView.layer.borderColor = UIColor.systemBlue.withAlphaComponent(1.5).cgColor
        aliasContentView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(60)
            make.bottom.equalToSuperview().inset(120)
        }
    }

    private func setUpContentViewTitleLabel() {
        aliasContentView.addSubview(contentViewTitleLabel)
        contentViewTitleLabel.text = "Разделитесь на команды"
        contentViewTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        contentViewTitleLabel.numberOfLines = 2
        contentViewTitleLabel.textAlignment = .center
        contentViewTitleLabel.textColor = .systemRed.withAlphaComponent(0.7)
        contentViewTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(70)
            make.trailing.equalToSuperview().inset(70)
        }
    }

    private func setUpTeamsCollectionView() {
        aliasContentView.addSubview(teamsCollectionView)
        teamsCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
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

        startButton.snp.makeConstraints { make in
            make.top.equalTo(aliasContentView.snp.bottom).offset(10)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(50)
            make.leading.equalToSuperview().offset(90)
        }
    }

    private func setUpOptionsButton() {
        addSubview(optionButton)
        optionButton.backgroundColor = .systemOrange.withAlphaComponent(1.3)
        optionButton.layer.cornerRadius = 10
        optionButton.layer.borderWidth = 3
        let buttonImage: UIImage = .settingIcon.resizeImage(newSize: CGSize(width: 30.0, height: 30.0))
        optionButton.setImage(buttonImage, for: .normal)
        optionButton.imageView?.contentMode = .center
        optionButton.layer.borderColor = UIColor.systemOrange.withAlphaComponent(1.1).cgColor
        let optionsAction: UIAction = UIAction { [weak self] _ in
            self?.optionsTapped?()
        }
        optionButton.addAction(optionsAction, for: .touchUpInside)

        optionButton.snp.makeConstraints { make in
            make.top.equalTo(aliasContentView.snp.bottom).offset(10)
            make.trailing.equalTo(startButton.snp.leading).inset(-10)
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().inset(50)
        }
    }

    private func setUpBackButton() {
        aliasContentView.addSubview(backButton)
        let backAction: UIAction = UIAction { [weak self] _ in
            self?.backTapped?()
        }
        backButton.addAction(backAction, for: .touchUpInside)

        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.width.height.equalTo(30)
        }
    }

}
