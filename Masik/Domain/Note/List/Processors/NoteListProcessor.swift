//
//  NoteListProcessor.swift
//  Masik
//
//  Created by Roman Lomtev on 17.06.2025.
//

import Foundation

final class NoteListProcessor: Processor {
    
    typealias Intent = NoteListIntent
    
    weak var handler: (any NoteListHandler)?
    
    private let interactor: NoteListInteractor

    init(interactor: NoteListInteractor) {
        self.interactor = interactor
    }
    
    func process(intent: NoteListIntent) {
        switch intent {
            
        case .load:
            handler?.handle(intent: .showLoading)
            Task {
                do {
                    let noteList = try await interactor.loadNoteList()
                    handler?.handle(intent: .showLoaded(noteList))
                } catch {
                    handler?.handle(intent: .showError(error.localizedDescription))
                }
            }
            
        case .delete(let id):
            handler?.handle(intent: .showDeleted(id: id))
            Task {
                do {
                    try await interactor.deleteNote(id: id)
                } catch {
                }
            }
            
        case .toggleDone(let id, let isDone):
            handler?.handle(intent: .showToggledDone(id: id, isDone: isDone))
            Task {
                do {
                    try await interactor.toggleDone(id: id, isDone: isDone)
                } catch {
                }
            }
            
        default:
            handler?.handle(intent: intent)
        }
    }
}
