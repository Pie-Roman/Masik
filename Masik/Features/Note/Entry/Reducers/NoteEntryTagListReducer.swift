//
//  NoteEntryTagListReducer.swift
//  Masik
//
//  Created by Роман Ломтев on 02.08.2025.
//

class NoteEntryTagListReducer: Reducer {
    
    typealias State = NoteEntryTagListState
    typealias Intent = NoteEntryTagListIntent
    
    func reduce(currentState: NoteEntryTagListState, intent: NoteEntryTagListIntent) -> NoteEntryTagListState {
        switch intent {
            
        case .showLoading:
            guard case .loaded(let tags) = currentState else {
                return .loading(tags: [])
            }
            return .loading(tags: tags)
            
        case .showLoaded(let noteList):
            return .loaded(tags: noteList)
            
        case .showAdded(let tag):
            guard case .loading(let tags) = currentState else {
                return currentState
            }
            let all = tags + [tag]
            return .loaded(tags: all)
            
        default:
            return currentState
        }
    }
}
