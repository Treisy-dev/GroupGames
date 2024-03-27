//
//  GameScreenView.swift
//  GroupGames
//
//  Created by Давид Васильев on 24.03.2024.
//

import SnapKit
import Koloda
import UIKit

class FiveSecondsGameScreenView: UIView {

    lazy var kolodaView: KolodaView = KolodaView()
    private lazy var nameLabel: UILabel = UILabel()
    private lazy var taskLabel: UILabel = UILabel()
    private lazy var checkTaskButton = FiveSecondsGameButtonFabric.shared.makeTransparentButton(title: "Посмотреть задание")
    private lazy var timerLabel: UILabel = UILabel()
    private lazy var exitButton = FiveSecondsGameButtonFabric.shared.makeExitButton()
    lazy var scoresCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 60, height: 80)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()

    var checkTaskTappedClosure: (() -> Void)?
    var timerDidFinishClosure: (() -> Void)?
    var exitButtonTapped: (() -> Void)?
    var timer: Timer?
    var count = 6

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpTeamsCollectionView()
        setUpKolodaView()
        setUpTimerLabel()
        setUpCheckTaskButton()
        setUpBackground()
        setUpExitButton()
    }

    private func setUpBackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = .backOrange
        backgroundImage.contentMode = .scaleAspectFill
        self.insertSubview(backgroundImage, at: 0)
    }

    private func setUpTeamsCollectionView() {
        addSubview(scoresCollectionView)
        scoresCollectionView.backgroundColor = .clear
        scoresCollectionView.showsHorizontalScrollIndicator = false
        scoresCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(100)
        }
    }

    private func setUpKolodaView() {
        addSubview(kolodaView)
        kolodaView.backgroundColor = .clear
        kolodaView.layer.cornerRadius = 26
        kolodaView.layer.masksToBounds = false
        kolodaView.layer.shadowColor = UIColor.black.cgColor
        kolodaView.layer.shadowOpacity = 0.5
        kolodaView.layer.shadowOffset = CGSize(width: 0, height: 2)
        kolodaView.layer.shadowRadius = 4
        kolodaView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(20)
            make.height.equalTo(300)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
        }
    }

    private func setUpTimerLabel() {
        addSubview(timerLabel)
        timerLabel.font = UIFont.boldSystemFont(ofSize: 56.0)
        timerLabel.text = " "
        timerLabel.textAlignment = .center
        timerLabel.minimumScaleFactor = 0.5
        timerLabel.adjustsFontSizeToFitWidth = true
        timerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(180)
            make.width.equalTo(140)
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
        }
    }

    @objc func updateTimer() {
        count -= 1
        timerLabel.text = "\(count)"
        if count == 0 {
            stopTimer()
            timerDidFinishClosure?()
        }
    }

    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    func stopTimer() {
        timerLabel.text = ""
        timer?.invalidate()
        timer = nil
        count = 6
    }

    func resetTimer() {
        stopTimer()
        count = 6
        timerLabel.isHidden = false
        startTimer()
    }

    func unHiddenCheckButton() {
        checkTaskButton.isHidden = false
    }

    private func setUpCheckTaskButton() {
        addSubview(checkTaskButton)
        let action: UIAction = UIAction { [weak self] _ in
            self?.checkTaskTappedClosure?()
            self?.checkTaskButton.isHidden = true

        }
        checkTaskButton.addAction(action, for: .touchUpInside)
        checkTaskButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
            make.bottom.equalToSuperview().inset(60)
        }
    }

    private func setUpExitButton() {
        addSubview(exitButton)
        let optionsAction: UIAction = UIAction { [weak self] _ in
            self?.exitButtonTapped?()
        }
        exitButton.addAction(optionsAction, for: .touchUpInside)
        exitButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(64)
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(40)
        }
    }
}
extension FiveSecondsGameScreenView {
    func startAnimation() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.1
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 5, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 5, y: self.center.y))

        self.layer.add(animation, forKey: "position")
    }
}
