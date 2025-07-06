//
//  NoteActionsReducer.swift
//  Masik
//
//  Created by Роман Ломтев on 07.07.2025.
//

class NoteActionsReducer: Reducer {
    
    typealias State = NoteActionsState
    typealias Intent = NoteActionsIntent
    
    func reduce(currentState: NoteActionsState, intent: NoteActionsIntent) -> NoteActionsState {
        switch intent {
            
        case .cancel:
            return .cancelled
            
        case .delete(let id):
            return .deleted
        }
    }
}

