//
//  NoteTagEntryReducer.swift
//  Masik
//
//  Created by Роман Ломтев on 01.08.2025.
//

class NoteTagEntryReducer: Reducer {
    
    typealias State = NoteTagEntryState
    typealias Intent = NoteTagEntryIntent
    
    func reduce(currentState: NoteTagEntryState, intent: NoteTagEntryIntent) -> NoteTagEntryState {
        switch intent {
            
        case .showAdded(let tag):
            return .added(tag: tag)

        case .showUpdated(let tag):
            return .updated(tag: tag)

        default:
            return currentState
        }
    }
}
