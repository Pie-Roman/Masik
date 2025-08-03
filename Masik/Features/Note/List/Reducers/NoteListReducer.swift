//
//  NoteListReducer.swift
//  Masik
//
//  Created by Роман Ломтев on 06.07.2025.
//

import Foundation

class NoteListReducer: Reducer {
    
    typealias State = NoteListState
    typealias Intent = NoteListIntent
    
    func reduce(currentState: NoteListState, intent: NoteListIntent) -> NoteListState {
        switch intent {
            
        case .showLoading:
            guard case .loaded(let noteList) = currentState else {
                return .loading(NoteList(tags: [], items: []))
            }
            return .loading(noteList)
            
        case .showLoaded(let noteList):
            return .loaded(noteList)
            
        case .showAdded(let note):
            guard case .loading(let noteList) = currentState else {
                return currentState
            }
            let all = [note] + noteList.items
            return .loaded(NoteList(tags: noteList.tags, items: all))
            
        case .showUpdated(let note):
            guard case .loading(let noteList) = currentState else {
                return currentState
            }
            let all = noteList.items.map { item in
                item.id == note.id ? note : item
            }
            return .loaded(NoteList(tags: noteList.tags, items: all))
            
        case .showDeleted(let id):
            guard case .loaded(let noteList) = currentState else {
                return currentState
            }
            let filtered = noteList.items.filter { $0.id != id }
            return .loaded(NoteList(tags: noteList.tags, items: filtered))

        case .showError(let msg):
            return .error(msg)
            
        default:
            return currentState
        }
    }
}
