//
//  NoteEntryReducer.swift
//  Masik
//
//  Created by Роман Ломтев on 19.07.2025.
//

import Foundation

class NoteEntryReducer: Reducer {
    
    typealias State = NoteEntryState
    typealias Intent = NoteEntryIntent
    
    func reduce(currentState: NoteEntryState, intent: NoteEntryIntent) -> NoteEntryState {
        switch intent {
            
        case .showAdded(let note):
            return .added(note: note)
            
        case .showUpdated(let id, let note):
            return .updated(note: note)
            
        default:
            return currentState
        }
    }
}

