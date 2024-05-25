//
//  TeamTableViewCell.swift
//  GroupGames
//
//  Created by Кирилл Щёлоков on 24.03.2024.
//

import UIKit
import SnapKit

class AliasTeamTableViewCell: UITableViewCell {

    lazy var teamImageView: UIImageView = UIImageView()
    lazy var teamBackgroundView: UIView = UIView()
    lazy var teamLabel: UILabel = UILabel()
    lazy var teamScoreLabel: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpTeamBackgroundView()
        setUpTeamImageView()
        setUpTeamLabel()
        setUpTeamScoreLabel()
    }

    func config(teamName: String, teamImage: UIImage, backgroundColor: UIColor) {
        teamLabel.text = teamName
        teamImageView.image = teamImage
        teamBackgroundView.backgroundColor = backgroundColor
    }

    private func setUpTeamBackgroundView() {
        addSubview(teamBackgroundView)
        teamBackgroundView.layer.cornerRadius = 30
        teamBackgroundView.layer.borderWidth = 3
        teamBackgroundView.layer.borderColor = UIColor.white.cgColor
        teamBackgroundView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(60)
        }
    }

    private func setUpTeamImageView() {
        teamBackgroundView.addSubview(teamImageView)
        teamImageView.contentMode = .scaleToFill
        teamImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(40)
        }
    }

    private func setUpTeamLabel() {
        addSubview(teamLabel)
        teamLabel.font = UIFont.boldSystemFont(ofSize: 16)
        teamLabel.adjustsFontSizeToFitWidth = true
        teamLabel.textColor = .black

        teamLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(teamBackgroundView.snp.trailing).offset(10)
        }
    }

    private func setUpTeamScoreLabel() {
        addSubview(teamScoreLabel)
        teamScoreLabel.text = "0"
        teamScoreLabel.font = UIFont.boldSystemFont(ofSize: 20)
        teamScoreLabel.adjustsFontSizeToFitWidth = true
        teamScoreLabel.textColor = .red.withAlphaComponent(0.7)
        teamScoreLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
        }
    }

}
