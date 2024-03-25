//
//  PlayersCollectionViewCell.swift
//  GroupGames
//
//  Created by Давид Васильев on 25.03.2024.
//

import UIKit

class FiveSecondsPlayersCollectionViewCell: UICollectionViewCell {

    private lazy var playerImageView: UIImageView = UIImageView()
    private lazy var playerBackgroundView: UIView = UIView()
    private lazy var teamLabel: UILabel = UILabel()
    private lazy var deleteButton: UIButton = UIButton()

    var deleteTapped: ((_ teamName: String) -> Void)?

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
        setUpTeamLabel()
        setUpDeleteButton()
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
        layer.shadowOffset = CGSize(width: 0, height: -2) // Смещение тени вниз
        layer.shadowRadius = 10 // Радиус тени
        layer.shadowOpacity = 0.3
        layer.shadowPath = UIBezierPath(roundedRect: backgroundView?.bounds ?? bounds, cornerRadius: 68).cgPath
    }

    func config(teamName: String, teamImage: UIImage) {
        teamLabel.text = teamName
        playerImageView.image = teamImage
    }

    private func setUpTeamBackgroundView() {
        addSubview(playerBackgroundView)
        playerBackgroundView.layer.cornerRadius = 8
        playerBackgroundView.layer.borderWidth = 3
        playerBackgroundView.layer.borderColor = UIColor.white.cgColor
        playerBackgroundView.backgroundColor = .white
        playerBackgroundView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
        }
    }

    private func setUpTeamImageView() {
        playerBackgroundView.addSubview(playerImageView)
        playerImageView.contentMode = .scaleToFill
        playerImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.height.width.equalTo(40)
        }
    }

    private func setUpTeamLabel() {
        addSubview(teamLabel)
        teamLabel.font = UIFont.boldSystemFont(ofSize: 16)
        teamLabel.adjustsFontSizeToFitWidth = true

        teamLabel.snp.makeConstraints { make in
            make.top.equalTo(14)
            make.leading.equalToSuperview().offset(60)
        }
    }

    private func setUpDeleteButton() {
        addSubview(deleteButton)
        deleteButton.backgroundColor = .clear
        deleteButton.setImage(.trash5S, for: .normal)
        let deleteAction: UIAction = UIAction { [weak self] _ in
            self?.deleteTapped?(self?.teamLabel.text ?? "")
        }
        deleteButton.addAction(deleteAction, for: .touchUpInside)
        deleteButton.snp.makeConstraints { make in
            make.top.equalTo(8)
            make.height.width.equalTo(28)
            make.trailing.equalToSuperview().inset(5)
        }
    }
}
