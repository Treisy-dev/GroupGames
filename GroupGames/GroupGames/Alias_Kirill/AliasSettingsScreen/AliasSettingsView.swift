//
//  SettingsView.swift
//  GroupGames
//
//  Created by Кирилл Щёлоков on 24.03.2024.
//
import SnapKit
import UIKit

final class AliasSettingsView: UIView {

    private lazy var settingsContentView: UIView = UIView()
    lazy var settingsLabel: UILabel = UILabel()
    lazy var durationLabel: UILabel = UILabel()
    lazy var durationSegmentControl: UISegmentedControl = UISegmentedControl(items: ["30", "60", "90"])
    lazy var pointsLabel: UILabel = UILabel()
    lazy var pointsSegmentControl: UISegmentedControl = UISegmentedControl(items: ["25", "50", "75", "100"])

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBlue.withAlphaComponent(1.1)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpContentView()
        setUpSettingLabel()
        setUpDurationLabel()
        setUpDurationSegmentControl()
        setUpPointsLabel()
        setUpPointsSegmentControl()
    }

    private func setUpContentView() {
        addSubview(settingsContentView)
        settingsContentView.backgroundColor = .white
        settingsContentView.layer.cornerRadius = 20
        settingsContentView.layer.borderWidth = 3
        settingsContentView.layer.borderColor = UIColor.systemBlue.withAlphaComponent(1.5).cgColor
        settingsContentView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(60)
            make.bottom.equalToSuperview().inset(60)
        }
    }

    private func setUpSettingLabel() {
        settingsContentView.addSubview(settingsLabel)
        settingsLabel.text = "Настройки"
        settingsLabel.textColor = .systemRed.withAlphaComponent(0.7)
        settingsLabel.textAlignment = .center
        settingsLabel.font = UIFont.boldSystemFont(ofSize: 24)
        settingsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }
    }

    private func setUpDurationLabel() {
        settingsContentView.addSubview(durationLabel)
        durationLabel.text = "Длительность раунда"
        durationLabel.font = UIFont.systemFont(ofSize: 14)
        durationLabel.textColor = .black
        durationLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.top.equalTo(settingsLabel.snp.bottom).offset(20)
        }
    }

    private func setUpDurationSegmentControl() {
        settingsContentView.addSubview(durationSegmentControl)
        durationSegmentControl.selectedSegmentIndex = 0
        durationSegmentControl.selectedSegmentTintColor = .systemOrange
        durationSegmentControl.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().inset(5)
            make.top.equalTo(durationLabel.snp.bottom).offset(5)
        }
    }

    private func setUpPointsLabel() {
        settingsContentView.addSubview(pointsLabel)
        pointsLabel.text = "Очков для победы"
        pointsLabel.font = UIFont.systemFont(ofSize: 14)
        pointsLabel.textColor = .black
        pointsLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.top.equalTo(durationSegmentControl.snp.bottom).offset(20)
        }
    }

    private func setUpPointsSegmentControl() {
        settingsContentView.addSubview(pointsSegmentControl)
        pointsSegmentControl.selectedSegmentIndex = 0
        pointsSegmentControl.selectedSegmentTintColor = .systemOrange
        pointsSegmentControl.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().inset(5)
            make.top.equalTo(pointsLabel.snp.bottom).offset(5)
        }
    }
}
