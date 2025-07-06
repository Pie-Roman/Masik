//
//  NoteActionsProcessor.swift
//  Masik
//
//  Created by Роман Ломтев on 07.07.2025.
//

final class NoteActionsProcessor: Processor {
    
    typealias Intent = NoteActionsIntent
    
    weak var handler: (any NoteActionsHandler)?
    
    private let interactor: NoteActionsInteractor

    init(interactor: NoteActionsInteractor) {
        self.interactor = interactor
    }
    
    func process(intent: NoteActionsIntent) {
        switch intent {
            
        case .delete(let id):
            handler?.handle(intent: intent)
            Task {
                do {
                    try await interactor.deleteNote(id: id)
                } catch {
                }
            }
            
        default:
            handler?.handle(intent: intent)
        }
    }
}

