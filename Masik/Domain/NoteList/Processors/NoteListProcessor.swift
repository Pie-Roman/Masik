//
//  NoteListProcessor.swift
//  Masik
//
//  Created by Roman Lomtev on 17.06.2025.
//

import Foundation

final class NoteListProcessor {
    private let interactor: NoteListInteractor

    init(interactor: NoteListInteractor) {
        self.interactor = interactor
    }

    func process(currentState: NoteListState, intent: NoteListIntent) async -> NoteListState {
        switch intent {
        case .load:
            do {
                let noteList = try await interactor.loadNotes()
                return .loaded(noteList)
            } catch {
                return .error(error.localizedDescription)
            }
        case .add(let noteBody):
            guard case .loaded(let currentList) = currentState else {
                return currentState
            }
            do {
                let note = try await interactor.addNote(noteBody: noteBody)
                let all = currentList.items + [note]
                return .loaded(NoteList(items: all))
            } catch {
                return .error(error.localizedDescription)
            }
        case .delete(let id):
            guard case .loaded(let currentList) = currentState else {
                return currentState
            }
            do {
                try await interactor.deleteNote(id: id)
                let filtered = currentList.items.filter { $0.id != id }
                return .loaded(NoteList(items: filtered))
            } catch {
                return .error(error.localizedDescription)
            }
        case .toggleDone(let id, let isDone):
            guard case .loaded(let currentList) = currentState else {
                return currentState
            }
            do {
                let updatedNote = try await interactor.toggleDone(id: id, isDone: isDone)
                let updatedItems = currentList.items.map { $0.id == id ? updatedNote ?? $0 : $0 }
                return .loaded(NoteList(items: updatedItems))
            } catch {
                return .error(error.localizedDescription)
            }
        case .showError(let msg):
            return .error(msg)
        }
    }
}
