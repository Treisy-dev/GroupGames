//
//  FiveSecondsGameButtonFabric.swift
//  GroupGames
//
//  Created by Давид Васильев on 27.03.2024.
//

import UIKit

final class FiveSecondsGameButtonFabric {
    public static let shared = FiveSecondsGameButtonFabric()

    private init() {}

    func makeTransparentButton(title: String) -> UIButton {
        let button: UIButton = UIButton()
        button.backgroundColor = .clear.withAlphaComponent(0.2)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.systemBlue.withAlphaComponent(1.3).cgColor

        return button
    }

    func makeExitButton() -> UIButton {
        let button: UIButton = UIButton()
        button.backgroundColor = .clear
        button.setImage(.exit5S, for: .normal)

        return button
    }
}
