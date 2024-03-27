//
//  ScoresCollectionViewCell.swift
//  GroupGames
//
//  Created by Давид Васильев on 25.03.2024.
//

import UIKit

class FiveSecondsScoresCollectionViewCell: UICollectionViewCell {

    private lazy var playerImageView: UIImageView = UIImageView()
    private lazy var playerBackgroundView: UIView = UIView()
    lazy var scoreLabel: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpTeamBackgroundView()
        setUpTeamImageView()
        setUpScoreLabel()
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
        layer.shadowOffset = CGSize(width: 0, height: -2) // Смещение тени вниз
        layer.shadowRadius = 10 // Радиус тени
        layer.shadowOpacity = 0.3
        layer.shadowPath = UIBezierPath(roundedRect: backgroundView?.bounds ?? bounds, cornerRadius: 68).cgPath
    }

    func config<T>(score: T, teamImage: UIImage) {
        scoreLabel.text = "\(score)"
        playerImageView.image = teamImage
    }

    private func setUpTeamBackgroundView() {
        addSubview(playerBackgroundView)
        playerBackgroundView.layer.cornerRadius = 20
        playerBackgroundView.layer.borderWidth = 3
        playerBackgroundView.layer.borderColor = UIColor.white.cgColor
        playerBackgroundView.backgroundColor = .white
        playerBackgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview()
        }
    }

    private func setUpTeamImageView() {
        playerBackgroundView.addSubview(playerImageView)
        playerImageView.contentMode = .scaleToFill
        playerImageView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.width.height.equalTo(30)
        }
    }

    private func setUpScoreLabel() {
        addSubview(scoreLabel)
        scoreLabel.font = UIFont.boldSystemFont(ofSize: 16)
        scoreLabel.adjustsFontSizeToFitWidth = true
        scoreLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
}
