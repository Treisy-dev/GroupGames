//
//  ViewModel.swift
//  GroupGames
//
//  Created by surexnx on 23.03.2024.
//

protocol ViewModel {
    associatedtype Intent
    func trigger(_ intent: Intent)
}
