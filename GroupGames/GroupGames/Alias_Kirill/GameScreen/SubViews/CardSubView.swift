//
//  CardSubView.swift
//  GroupGames
//
//  Created by Кирилл Щёлоков on 24.03.2024.
//
import SnapKit
import UIKit

class CardSubView: UIView {

    lazy var cardLabel: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.borderWidth = 4
        layer.borderColor = UIColor.systemBlue.withAlphaComponent(1.1).cgColor
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        setUpCardLabel()
    }

    func config(cardText: String) {
        cardLabel.text = cardText
    }

    private func setUpCardLabel() {
        addSubview(cardLabel)
        cardLabel.textAlignment = .center
        cardLabel.textColor = .black
        cardLabel.adjustsFontSizeToFitWidth = true
        cardLabel.numberOfLines = 0
        cardLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.centerY.equalToSuperview()
        }
    }
}
