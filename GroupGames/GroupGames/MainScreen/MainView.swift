//
//  MainView.swift
//  GroupGames
//
//  Created by Кирилл Щёлоков on 11.03.2024.
//
import SnapKit
import UIKit

protocol MainViewDelegate: AnyObject {
    func didYesNoButtonTapped()
    func didAliasButtonTapped()
    func didSpyButtonTapped()
}

final class MainView: UIView {

    lazy var mainTitleLabel: UILabel = UILabel()

    lazy var spyButton: UIButton = GameButtonFubric.shared.makeGameButton(
        label: "Spy",
        labelColor: UIColor.white,
        buttonColor: .red.withAlphaComponent(0.7))
    lazy var yesNoButton: UIButton = GameButtonFubric.shared.makeGameButton(
        label: "FiveSeconds",
        labelColor: UIColor.black,
        buttonColor: .yellow.withAlphaComponent(0.7))
    lazy var aliasButton: UIButton = GameButtonFubric.shared.makeGameButton(
        label: "Alias",
        labelColor: UIColor.white,
        buttonColor: .blue.withAlphaComponent(0.7))

    weak var delegate: MainViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray.withAlphaComponent(0.9)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpMainTitleLabel()
        setUpYesNoButton()
        setUpAliasButton()
        setUpSpyButton()
    }

    private func setUpMainTitleLabel() {
        addSubview(mainTitleLabel)
        mainTitleLabel.text = "GroupGame"
        mainTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        mainTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }
    }

    private func setUpYesNoButton() {
        addSubview(yesNoButton)
        let yesNoAction: UIAction = UIAction { [weak self] _ in
            self?.delegate?.didYesNoButtonTapped()
        }
        yesNoButton.addAction(yesNoAction, for: .touchUpInside)
        yesNoButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(50)
            make.width.equalTo(130)
            make.height.equalTo(100)
            make.top.equalToSuperview().offset(300)
        }
    }

    private func setUpAliasButton() {
        addSubview(aliasButton)
        let aliasAction: UIAction = UIAction { [weak self] _ in
            self?.delegate?.didAliasButtonTapped()
        }
        aliasButton.addAction(aliasAction, for: .touchUpInside)
        aliasButton.accessibilityIdentifier = "aliasButton"
        aliasButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(50)
            make.width.equalTo(130)
            make.height.equalTo(100)
            make.top.equalToSuperview().offset(300)
        }
    }

    private func setUpSpyButton() {
        addSubview(spyButton)
        let spyAction: UIAction = UIAction { [weak self] _ in
            self?.delegate?.didSpyButtonTapped()
        }
        spyButton.addAction(spyAction, for: .touchUpInside)
        spyButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(130)
            make.height.equalTo(100)
            make.top.equalTo(aliasButton.snp.bottom).offset(20)
        }
    }
}
