//
//  GameView.swift
//  GroupGames
//
//  Created by Кирилл Щёлоков on 24.03.2024.
//
import Koloda
import SnapKit
import UIKit

class AliasGameView: UIView {

    lazy var gradientSubView: GradientSubView = GradientSubView()
    lazy var yesButton: UIButton = UIButton()
    lazy var noButton: UIButton = UIButton()
    lazy var kolodaView: KolodaView = KolodaView()

    lazy var timerLabel: UILabel = UILabel()
    var remainingTime: Int = AliasUserDefaultsDataManager.shared.getDuration()
    var timer: Timer?

    var timerFinished: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpGradientSubView()
        setUpTimerLabel()
        startTimer()
        setUpKolodaView()
        setUpYesButton()
        setUpNoButton()
    }

    private func setUpGradientSubView() {
        addSubview(gradientSubView)
        gradientSubView.backgroundColor = .clear
        gradientSubView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(40)
            make.top.equalToSuperview().inset(-60)
        }
    }

    private func setUpTimerLabel() {
        gradientSubView.addSubview(timerLabel)
        timerLabel.text = String(remainingTime)
        timerLabel.textAlignment = .center
        timerLabel.font = UIFont.systemFont(ofSize: 24)
        timerLabel.textColor = .black
        timerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(60)
        }
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            if self?.remainingTime ?? 0 > 0 {
                self?.timerLabel.text = String(self?.remainingTime ?? 0)
                self?.remainingTime -= 1
            } else {
                self?.timer?.invalidate()
                self?.timerFinished?()
            }
        }
    }

    private func setUpKolodaView() {
        gradientSubView.addSubview(kolodaView)
        kolodaView.backgroundColor = .white
        kolodaView.layer.cornerRadius = 20
        kolodaView.layer.masksToBounds = false
        kolodaView.layer.shadowColor = UIColor.black.cgColor
        kolodaView.layer.shadowOpacity = 0.5
        kolodaView.layer.shadowPath = UIBezierPath(roundedRect: kolodaView.bounds, cornerRadius: 68).cgPath
        kolodaView.layer.shadowRadius = 4

        kolodaView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(300)
            make.leading.equalToSuperview().offset(60)
            make.trailing.equalToSuperview().inset(60)
        }
    }

    private func setUpYesButton() {
        gradientSubView.addSubview(yesButton)
        yesButton.layer.cornerRadius = 15
        yesButton.layer.borderWidth = 2
        yesButton.layer.borderColor = UIColor.systemBlue.withAlphaComponent(1.1).cgColor
        yesButton.backgroundColor = .systemBlue.withAlphaComponent(1.7)
        let icon = UIImage.checkmarkIcon.resizeImage(newSize: CGSize(width: 30.0, height: 30.0))
        yesButton.setImage(icon, for: .normal)
        yesButton.imageView?.contentMode = .scaleAspectFit
        yesButton.imageView?.tintColor = .white
        let yesAction: UIAction = UIAction { [weak self] _ in
            self?.kolodaView.swipe(.right)
        }
        yesButton.addAction(yesAction, for: .touchUpInside)
        yesButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(80)
            make.height.equalTo(60)
            make.width.equalTo(170)
            make.trailing.equalToSuperview().inset(20)
        }
    }

    private func setUpNoButton() {
        gradientSubView.addSubview(noButton)
        noButton.layer.cornerRadius = 15
        noButton.layer.borderWidth = 2
        noButton.layer.borderColor = UIColor.systemBlue.withAlphaComponent(1.1).cgColor
        let icon = UIImage.redCross.resizeImage(newSize: CGSize(width: 40.0, height: 40.0))
        noButton.setImage(icon, for: .normal)
        noButton.imageView?.contentMode = .scaleAspectFit
        noButton.imageView?.tintColor = .white
        let noAction: UIAction = UIAction { [weak self] _ in
            self?.kolodaView.swipe(.left)
        }
        noButton.addAction(noAction, for: .touchUpInside)
        noButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(80)
            make.height.equalTo(60)
            make.width.equalTo(170)
            make.leading.equalToSuperview().offset(20)
        }
    }

}
