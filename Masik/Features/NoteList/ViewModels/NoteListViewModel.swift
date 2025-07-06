//
//  NoteListViewModel.swift
//  Masik
//
//  Created by Roman Lomtev on 17.06.2025.
//

import SwiftUI
import Foundation

final class NoteListViewModel: ObservableObject {
    
    @Published private(set) var state: NoteListState = .idle
    
    private let processor: NoteListProcessor
    private let reducer: NoteListReducer

    init(
        interactor: NoteListInteractor = NoteListInteractor(),
        reducer: NoteListReducer = NoteListReducer()
    ) {
        self.processor = NoteListProcessor(interactor: interactor)
        self.reducer = reducer
        self.processor.handler = self
    }
    
    func send(intent: Intent) {
        processor.process(intent: intent)
    }
}

extension NoteListViewModel: NoteListHandler {
    
    func handle(intent: NoteListIntent) {
        let newState = reducer.reduce(currentState: state, intent: intent)
        self.state = newState
    }
}
