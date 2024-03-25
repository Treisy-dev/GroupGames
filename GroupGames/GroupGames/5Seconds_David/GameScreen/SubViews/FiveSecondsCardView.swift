//
//  CardView.swift
//  GroupGames
//
//  Created by Давид Васильев on 24.03.2024.
//

import UIKit

class FiveSecondsCardView: UIView {

    private lazy var nameLabel: UILabel = UILabel()
    private lazy var taskLabel: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        self.backgroundColor = .white
        self.layer.cornerRadius = 26
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpNameLabel()
        setUpTaskLabel()
    }

    private func setUpNameLabel() {
        addSubview(nameLabel)
        nameLabel.font = UIFont.systemFont(ofSize: 24.0)
        nameLabel.textAlignment = .center
        nameLabel.minimumScaleFactor = 0.5
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.height.equalTo(20)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
        }
    }

    private func setUpTaskLabel() {
        addSubview(taskLabel)
        taskLabel.font = UIFont.boldSystemFont(ofSize: 36.0)
        taskLabel.textAlignment = .center
        taskLabel.minimumScaleFactor = 0.5
        taskLabel.adjustsFontSizeToFitWidth = true
        taskLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.height.equalTo(80)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
    }

    func setFinalText() {
        taskLabel.text = "Задание выполнено?"
    }

    func configure(name: String, task: String) {
        nameLabel.text = name
        taskLabel.text = task
    }
}
