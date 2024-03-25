//
//  GameViewModel.swift
//  GroupGames
//
//  Created by Кирилл Щёлоков on 24.03.2024.
//
import Koloda
import Foundation

final class AliasGameViewModel: KolodaViewDataSource {

    let cardData: [String] = [
        "Вопрос 1", "Вопрос 2", "Вопрос 3", "Вопрос 4",
        "Вопрос 5", "Вопрос 6", "Вопрос 7", "Вопрос 8",
        "Вопрос 9", "Вопрос 10", "Вопрос 11", "Вопрос 12",
        "Вопрос 13", "Вопрос 14", "Вопрос 15", "Вопрос 16"]

    var points: Int = 0

    func koloda(_ koloda: Koloda.KolodaView, viewForCardAt index: Int) -> UIView {
        let card = AliasCardSubView(frame: CGRect())
        card.config(cardText: cardData[index])
        return card
    }

    func kolodaNumberOfCards(_ koloda: Koloda.KolodaView) -> Int {
        return cardData.count
    }

    func addPoint() {
        points += 1
    }
}
