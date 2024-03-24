//
//  SpyGameViewController.swift
//  GroupGames
//
//  Created by surexnx on 23.03.2024.
//

import UIKit
import Combine
import SnapKit

final class SpyGameViewController: UIViewController {

    // MARK: Private properties

    private var viewModel: SpyGameViewModel
    private var cancellebles: Set<AnyCancellable>
    private var tapGesture: UITapGestureRecognizer?
    private var tap: Bool = false

    private lazy var cardView: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var qustionsLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var nextQustionButton: UIButton = {
        let action = UIAction { [weak self] _ in
            self?.viewModel.trigger(.proccedButtonTapedNextQustion)
        }

        var button = UIButton(primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Следующий вопрос", for: .normal)
        return button
    }()

    private lazy var qustionsStackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [qustionsLabel, nextQustionButton])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isHidden = true
        return stackView
    }()

    private lazy var exitButton: UIButton = {
        let action = UIAction { [weak self] _ in
            self?.viewModel.trigger(.onClose)
        }
        let button = UIButton(primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Exit", for: .normal)
        return button
    }()

    // MARK: Initializators

    init(viewModel: SpyGameViewModel) {
        self.viewModel = viewModel
        cancellebles = []
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        view.backgroundColor = .white
        bindings()
        viewModel.start()
    }

    // MARK: Private methods

    private func bindings() {
        viewModel.$state.sink { [weak self] state in
            switch state {
            case .distributionOfJob:
                self?.distributionOfJob()
            case .startTimer:
                self?.viewElementsVisible()
                self?.removeTapGesture()
            case .gameOver:
                self?.viewModel.trigger(.onClose)
            case .wait:
                self?.viewModel.start()
            }
        }.store(in: &cancellebles)

        viewModel.$nameJob.sink { [weak self] value in
            self?.qustionsLabel.text = value
        }.store(in: &cancellebles)
    }

    private func distributionOfJob() {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        guard let tapGesture = tapGesture else { return }
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        tap.toggle()
        if tap {
            if let nameJob = viewModel.cards?.first {
                cardView.text = nameJob
                viewModel.cards?.removeFirst()
            } else {
                self.viewModel.trigger(.proccedButtonTapedNextQustion)
                viewModel.trigger(.starTimer)
            }
        } else {
            if let card = viewModel.cards?.first {
                cardView.text = "Нажмите"
                return
            }
            cardView.text = "Продолжить"
        }
    }

    private func removeTapGesture() {
        if let tapGesture = tapGesture {
            self.view.removeGestureRecognizer(tapGesture)
            self.tapGesture = nil
        }
    }

    private func viewElementsVisible() {
        cardView.isHidden = true
        qustionsStackView.isHidden = false
    }

    private func setupLayout() {
        view.addSubview(qustionsStackView)
        view.addSubview(cardView)
        view.addSubview(exitButton)

        exitButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(40)
        }

        qustionsStackView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }

        cardView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
