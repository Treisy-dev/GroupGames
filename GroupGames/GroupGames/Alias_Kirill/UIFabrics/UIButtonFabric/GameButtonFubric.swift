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

    func makeBackButton() -> UIButton {
        let button: UIButton = UIButton()
        button.backgroundColor = .systemOrange.withAlphaComponent(1.3)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 3
        button.setImage(UIImage.init(systemName: "arrowshape.backward"), for: .normal)
        button.imageView?.tintColor = .black
        button.imageView?.contentMode = .center
        button.layer.borderColor = UIColor.systemOrange.withAlphaComponent(1.1).cgColor

        return button
    }

    func makeNextButton(title: String) -> UIButton {
        let button: UIButton = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .systemBlue.withAlphaComponent(1.5)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.systemBlue.withAlphaComponent(1.3).cgColor

        return button
    }
}
