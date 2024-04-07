//
//  GradientSubView.swift
//  GroupGames
//
//  Created by Кирилл Щёлоков on 07.04.2024.
//

import UIKit

class GradientSubView: UIView {

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setUp() {
        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
        gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.systemBlue.withAlphaComponent(0.5).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
    }
}
