//
//  AliasAddTeamCollectionViewCell.swift
//  GroupGames
//
//  Created by Кирилл Щёлоков on 24.03.2024.
//

import SnapKit
import UIKit

class AliasTeamsAddCollectionViewCell: UICollectionViewCell {
    private lazy var addTeamButton: UIButton = UIButton()
    private lazy var addLabel: UILabel = UILabel()

    var addTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpAddTeamButton()
        setUpAddLabel()
    }

    private func setUpAddTeamButton() {
        addSubview(addTeamButton)
        addTeamButton.backgroundColor = .lightGray.withAlphaComponent(0.5)
        addTeamButton.setImage(.plusIcon, for: .normal)
        addTeamButton.imageView?.contentMode = .scaleAspectFill
        addTeamButton.layer.cornerRadius = 68
        let addAction: UIAction = UIAction { [weak self] _ in
            self?.addTapped?()
        }
        addTeamButton.addAction(addAction, for: .touchUpInside)

        addTeamButton.snp.makeConstraints { make in
            make.trailing.leading.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
        }
    }

    private func setUpAddLabel() {
        addSubview(addLabel)
        addLabel.font = UIFont.boldSystemFont(ofSize: 16)
        addLabel.textColor = .lightGray
        addLabel.textAlignment = .center
        addLabel.numberOfLines = 2
        addLabel.text = "Добавить команду"

        addLabel.snp.makeConstraints { make in
            make.top.equalTo(addTeamButton.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().inset(15)
        }
    }
}
