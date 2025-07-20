//
//  NoteEntryProcessor.swift
//  Masik
//
//  Created by Роман Ломтев on 19.07.2025.
//

import Foundation

final class NoteEntryProcessor: Processor {
    
    typealias Intent = NoteEntryIntent
    
    weak var handler: (any NoteEntryHandler)?
    
    private let interactor: NoteEntryInteractor

    init(interactor: NoteEntryInteractor) {
        self.interactor = interactor
    }
    
    func process(intent: NoteEntryIntent) {
        switch intent {
            
        case .add(let noteBody):
            Task {
                do {
                    let note = try await interactor.addNote(noteBody: noteBody)
                    handler?.handle(intent: .showAdded(note: note))
                } catch {
                }
            }
            
        case .update(let id, let noteBody):
            Task {
                do {
                    let note = try await interactor.updateNote(id: id, noteBody: noteBody)
                    handler?.handle(intent: .showUpdated(id: id, note: note))
                } catch {
                    
                }
            }
            
        default:
            handler?.handle(intent: intent)
        }
    }
}

