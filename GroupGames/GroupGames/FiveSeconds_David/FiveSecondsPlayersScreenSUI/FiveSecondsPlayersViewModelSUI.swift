//
//  FiveSecondsPlayersViewModelSUI.swift
//  GroupGames
//
//  Created by Давид Васильев on 25.05.2024.
//
import UIKit
import Foundation
class FiveSecondsPlayersViewModelSUI: ObservableObject {
    @Published var players: [Player] = [Player(id: UUID(), name: "Чудик", image: .alien), Player(id: UUID(), name: "Лягуха", image: .frog)]

    let playersNames = [
        ("Чудик", UIImage.alien),
        ("Лягуха", UIImage.frog),
        ("Каратэ Пацан", UIImage.panda),
        ("Батя", UIImage.viking),
        ("Тучка", UIImage.storm),
        ("Джулиан", UIImage.lemur)
    ]

    var index = 2

    func addPlayer() {
        if index != 6 {
            let player = playersNames[index]
            players.append(Player(id: UUID(), name: player.0, image: player.1))
            index += 1
        }
    }

    func deletePlayer(name: String) {
        if index >= 0 && players.count > 2{
            if let index = players.firstIndex(where: { $0.name == name }) {
                players.remove(at: index)
            }
            index -= 1
        }
    }
}

