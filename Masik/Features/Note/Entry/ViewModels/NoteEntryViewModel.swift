//
//  NoteEntryViewModel.swift
//  Masik
//
//  Created by Роман Ломтев on 19.07.2025.
//

import SwiftUI

final class NoteEntryViewModel: ObservableObject {
    
    @Published private(set) var state: NoteEntryState = .idle
    
    private let processor: NoteEntryProcessor
    private let reducer: NoteEntryReducer

    init(
        interactor: NoteEntryInteractor = NoteEntryInteractor(),
        reducer: NoteEntryReducer = NoteEntryReducer()
    ) {
        self.processor = NoteEntryProcessor(interactor: interactor)
        self.reducer = reducer
        self.processor.handler = self
    }
    
    func send(intent: Intent) {
        processor.process(intent: intent)
    }
}

extension NoteEntryViewModel: NoteEntryHandler {
    
    func handle(intent: NoteEntryIntent) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            let newState = self.reducer.reduce(currentState: state, intent: intent)
            self.state = newState
        }
    }
}
