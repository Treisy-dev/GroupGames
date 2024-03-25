//
//  ScoreView.swift
//  GroupGames
//
//  Created by Кирилл Щёлоков on 24.03.2024.
//
import SnapKit
import UIKit

class AliasScoreView: UIView {

    lazy var backButton: UIButton = GameButtonFubric.shared.makeBackButton()
    lazy var teamImageView: UIImageView = UIImageView()
    lazy var backgroundView: UIView = UIView()
    private lazy var startButton: UIButton = GameButtonFubric.shared.makeNextButton(title: "Начать игру")
    private lazy var scoreContentView: UIView = UIView()
    lazy var scoreTitleLabel: UILabel = UILabel()
    lazy var teamsTableView: UITableView = UITableView()

    var backTapped: (() -> Void)?
    var playTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBlue.withAlphaComponent(1.1)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func config(defaultTeams: [(String, UIImage, UIColor)]) {
        scoreTitleLabel.text = "Очередь команды '\(defaultTeams[0].0)'"
        teamImageView.image = defaultTeams[0].1
        backgroundView.backgroundColor = defaultTeams[0].2
    }

    private func setUp() {
        setUpContentView()
        setUpScoreTitleLabel()
        setUpBackgroundView()
        setUpTeamImageView()
        setUpTeamsTableView()
        setUpBackButton()
        setUpStartButton()
    }

    private func setUpContentView() {
        addSubview(scoreContentView)
        scoreContentView.backgroundColor = .white
        scoreContentView.layer.cornerRadius = 20
        scoreContentView.layer.borderWidth = 3
        scoreContentView.layer.borderColor = UIColor.systemBlue.withAlphaComponent(1.5).cgColor
        scoreContentView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(60)
            make.bottom.equalToSuperview().inset(120)
        }
    }

    private func setUpScoreTitleLabel() {
        scoreContentView.addSubview(scoreTitleLabel)
        scoreTitleLabel.textColor = .systemRed.withAlphaComponent(0.7)
        scoreTitleLabel.adjustsFontSizeToFitWidth = true
        scoreTitleLabel.numberOfLines = 2
        scoreTitleLabel.textAlignment = .center
        scoreTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)

        scoreTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
        }
    }

    private func setUpBackgroundView() {
        scoreContentView.addSubview(backgroundView)
        backgroundView.layer.cornerRadius = 75
        backgroundView.layer.borderWidth = 3
        backgroundView.layer.borderColor = UIColor.white.withAlphaComponent(0.6).cgColor
        backgroundView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(scoreTitleLabel.snp.bottom).offset(20)
            make.width.height.equalTo(150)
        }
    }

    private func setUpTeamImageView() {
        backgroundView.addSubview(teamImageView)
        teamImageView.contentMode = .scaleToFill
        teamImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(80)
        }
    }

    private func setUpTeamsTableView() {
        scoreContentView.addSubview(teamsTableView)
        teamsTableView.snp.makeConstraints { make in
            make.top.equalTo(backgroundView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().inset(8)
        }
    }

    private func setUpBackButton() {
        scoreContentView.addSubview(backButton)
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

    private func setUpStartButton() {
        addSubview(startButton)
        let startAction: UIAction = UIAction { [weak self] _ in
            self?.playTapped?()
        }
        startButton.addAction(startAction, for: .touchUpInside)

        startButton.snp.makeConstraints { make in
            make.top.equalTo(scoreContentView.snp.bottom).offset(10)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(50)
            make.leading.equalToSuperview().offset(20)
        }
    }
}
