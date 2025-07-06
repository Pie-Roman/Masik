//
//  Reducer.swift
//  Masik
//
//  Created by Роман Ломтев on 06.07.2025.
//

protocol Reducer {
    
    associatedtype State
    associatedtype Intent
    
    func reduce(currentState: State, intent: Intent) -> State
}
