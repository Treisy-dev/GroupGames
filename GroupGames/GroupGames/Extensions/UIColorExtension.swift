//
//  UIColorExtension.swift
//  GroupGames
//
//  Created by Кирилл Щёлоков on 24.03.2024.
//

import Foundation
import UIKit

extension UIColor {
    static func randomColor() -> UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0)
    }
}
