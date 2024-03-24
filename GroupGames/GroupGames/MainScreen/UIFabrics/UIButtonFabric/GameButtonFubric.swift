//
//  GameButtonFubric.swift
//  GroupGames
//
//  Created by Кирилл Щёлоков on 24.03.2024.
//

import Foundation
import UIKit

final class GameButtonFubric {
    public static let shared = GameButtonFubric()

    private init() {
    }

    func makeGameButton(label: String, labelColor: UIColor, buttonColor: UIColor) -> UIButton {
        let button: UIButton = UIButton()
        button.setTitle(label, for: .normal)
        button.setTitleColor(labelColor, for: .normal)
        button.backgroundColor = buttonColor
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor

        return button
    }
}
