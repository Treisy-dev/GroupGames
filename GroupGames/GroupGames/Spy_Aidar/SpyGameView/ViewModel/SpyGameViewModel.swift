//
//  SpyGameViewModel.swift
//  GroupGames
//
//  Created by surexnx on 23.03.2024.
//

import Foundation
import Combine

enum SpyGameViewIntent {
    case proccedButtonTapedNextQustion
    case starTimer
    case onClose
}

enum SpyGameViewState {
    case wait
    case distributionOfJob
    case startTimer
    case gameOver
}

final class SpyGameViewModel: ViewModel {

    // MARK: Private properties

    private weak var output: SpyGameModuleOutput?
    private let settings: Settings
    private var timer: Int?
    private var qustions: [String] = []
    private var countQustions = 0
    @Published private(set) var state: SpyGameViewState
    @Published private(set) var nameJob: String?

    // MARK: Internal properties

    var cards: [String]?

    // MARK: Initializators

    init(output: SpyGameModuleOutput, settings: Settings) {
        self.output = output
        self.settings = settings
        state = .wait
        setupSettings(settings: settings)
        setupQustions()
    }

    // MARK: Internal methods

    func trigger(_ itent: SpyGameViewIntent) {
        switch itent {
        case .proccedButtonTapedNextQustion:
            getQustions()
        case .onClose:
            output?.onClouse()
        case .starTimer:
            state = .startTimer
        }
    }

    func start() {
        state = .distributionOfJob
    }
    // MARK: Private methods

    private func setupSettings(settings: Settings) {
        guard let numPlayers = settings.players.first?.value else { return }
        var arrayPlayers = (1...numPlayers).map { "Работяга \($0)" }
        let randomSpy = Int.random(in: 0..<numPlayers)
        arrayPlayers[randomSpy] = "Шпион \(randomSpy + 1)"
        self.cards = arrayPlayers

        guard let timer = settings.timerInSec.first?.value else { return }
        self.timer = timer
    }

    private func setupQustions() {
        qustions = (1...10).map { "Вопрос \($0)" }
    }

    private func getQustions() {
        let index = countQustions % qustions.count
        nameJob = qustions[index]
        countQustions += 1
    }
}
