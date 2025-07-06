//
//  NoteActionsViewModel.swift
//  Masik
//
//  Created by Роман Ломтев on 06.07.2025.
//

import SwiftUI

final class NoteActionsViewModel: ObservableObject {
    
    @Published var state: NoteActionsState = .idle
    
    private let processor: NoteActionsProcessor
    private let reducer: NoteActionsReducer
    
    init(
        interactor: NoteActionsInteractor = NoteActionsInteractor(),
        reducer: NoteActionsReducer = NoteActionsReducer(),
    ) {
        self.processor = NoteActionsProcessor(interactor: interactor)
        self.reducer = reducer
        self.processor.handler = self
    }
    
    func send(intent: Intent) {
        processor.process(intent: intent)
    }
}

extension NoteActionsViewModel: NoteActionsHandler {
    
    func handle(intent: NoteActionsIntent) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            let newState = self.reducer.reduce(currentState: state, intent: intent)
            self.state = newState
        }
    }
}
