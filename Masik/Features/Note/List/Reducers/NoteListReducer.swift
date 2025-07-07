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
                return .loading(NoteList(items: []))
            }
            return .loading(noteList)
            
        case .showLoaded(let noteList):
            return .loaded(noteList)
            
        case .showAdded(let note):
            guard case .loading(let noteList) = currentState else {
                return currentState
            }
            let all = noteList.items + [note]
            return .loaded(NoteList(items: all))
            
        case .showDeleted(let id):
            guard case .loaded(let noteList) = currentState else {
                return currentState
            }
            let filtered = noteList.items.filter { $0.id != id }
            return .loaded(NoteList(items: filtered))
            
        case .showToggledDone(let id, let isDone):
            guard case .loaded(let noteList) = currentState else {
                return currentState
            }
            let updatedNotes = noteList.items.map { $0.id == id ?
                Note(
                    id: id,
                    body: NoteBody(
                        title: $0.body.title,
                        isDone: isDone
                    )
                )
                : $0
            }
            return .loaded(NoteList(items: updatedNotes))
            
        case .showError(let msg):
            return .error(msg)
            
        default:
            return currentState
        }
    }
}
