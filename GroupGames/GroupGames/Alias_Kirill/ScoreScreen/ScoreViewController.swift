//
//  ScoreViewController.swift
//  GroupGames
//
//  Created by Кирилл Щёлоков on 24.03.2024.
//

import UIKit

protocol GameDelegate: AnyObject {
    func updateScore(with newScore: Int)
    func passTurn()
}

final class ScoreViewController: UIViewController {

    private let contentView: ScoreView = .init()
    private var turning: Int = 0
    private var winFlag: (Bool, String, Int) = (false, "", 0)

    private let viewModel: ScoreViewModel

    init(viewModel: ScoreViewModel) {
        self.viewModel = viewModel
        contentView.config(defaultTeams: viewModel.defaultTeams)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.teamsTableView.delegate = self
        contentView.teamsTableView.dataSource = viewModel
        contentView.teamsTableView.register(TeamTableViewCell.self, forCellReuseIdentifier: TeamTableViewCell.reuseIdentifier)

        contentView.backTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }

        contentView.playTapped = { [weak self] in
            let gameViewController = GameViewController(viewModel: GameViewModel())
            gameViewController.delegate = self
            self?.navigationController?.pushViewController(gameViewController, animated: true)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if turning == 0 && winFlag.0 {
            let alert = UIAlertController(
                title: "Поздравляем!!!",
                message: "Команда '\(winFlag.1)' одержала победу!!",
                preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) {[weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
}

extension ScoreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension ScoreViewController: GameDelegate {
    func updateScore(with newScore: Int) {
        guard let cell = contentView.teamsTableView.cellForRow(at: IndexPath(row: turning, section: 0)) as? TeamTableViewCell else { return }
        guard let teamScore = cell.teamScoreLabel.text else { return }
        guard let intTeamScore = Int(teamScore) else { return }
        cell.teamScoreLabel.text = String(intTeamScore + newScore)
        if intTeamScore + newScore >= UserDefaultsDataManager.shared.getWinPoints() && intTeamScore + newScore > winFlag.2 {
            guard let teamName = cell.teamLabel.text else { return }
            winFlag = (true, teamName, intTeamScore + newScore)
        }
        cell.alpha = 0.5
        passTurn()

        if turning == 0 {
            makeCellsClear()
        }
        guard let cell = contentView.teamsTableView.cellForRow(at: IndexPath(row: turning, section: 0)) as? TeamTableViewCell else { return }
        contentView.scoreTitleLabel.text = "Очередь команды '\(cell.teamLabel.text ?? "")'"
        contentView.teamImageView.image = viewModel.defaultTeams[turning].1
        contentView.backgroundView.backgroundColor = viewModel.defaultTeams[turning].2
    }

    func passTurn() {
        turning = (turning + 1) % viewModel.defaultTeams.count
    }

    private func makeCellsClear() {
        for i in 0..<contentView.teamsTableView.numberOfRows(inSection: 0) {
            if let cell = contentView.teamsTableView.cellForRow(at: IndexPath(row: i, section: 0)) {
                cell.alpha = 1.0
            }
        }
    }
}
