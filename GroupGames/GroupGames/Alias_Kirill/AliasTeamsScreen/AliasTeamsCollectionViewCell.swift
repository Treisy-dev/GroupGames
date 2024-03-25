//
//  AliasTeamsCollectionViewCell.swift
//  GroupGames
//
//  Created by Кирилл Щёлоков on 24.03.2024.
//

import SnapKit
import UIKit

class AliasTeamsCollectionViewCell: UICollectionViewCell {

    private lazy var teamImageView: UIImageView = UIImageView()
    private lazy var teamBackgroundView: UIView = UIView()
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

    func config(teamName: String, teamImage: UIImage, backgroundColor: UIColor) {
        teamLabel.text = teamName
        teamImageView.image = teamImage
        teamBackgroundView.backgroundColor = backgroundColor
    }

    private func setUpTeamBackgroundView() {
        addSubview(teamBackgroundView)
        teamBackgroundView.layer.cornerRadius = 68
        teamBackgroundView.layer.borderWidth = 3
        teamBackgroundView.layer.borderColor = UIColor.white.cgColor
        teamBackgroundView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
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

        teamLabel.snp.makeConstraints { make in
            make.top.equalTo(teamBackgroundView.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
        }
    }

    private func setUpDeleteButton() {
        addSubview(deleteButton)
        deleteButton.backgroundColor = .white
        deleteButton.layer.cornerRadius = 15
        deleteButton.layer.borderWidth = 1
        deleteButton.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        deleteButton.setImage(.redCross, for: .normal)
        let deleteAction: UIAction = UIAction { [weak self] _ in
            self?.deleteTapped?(self?.teamLabel.text ?? "")
        }
        deleteButton.addAction(deleteAction, for: .touchUpInside)
        deleteButton.snp.makeConstraints { make in
            make.bottom.equalTo(teamLabel.snp.top).inset(-20)
            make.height.width.equalTo(30)
            make.trailing.equalToSuperview().inset(5)
        }
    }
}
