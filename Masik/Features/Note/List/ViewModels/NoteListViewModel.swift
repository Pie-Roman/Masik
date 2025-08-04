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

    private let noteListTabsViewModel: NoteListTabsViewModel

    init(
        noteListTabsViewModel: NoteListTabsViewModel,
        interactor: NoteListInteractor = NoteListInteractor(),
        reducer: NoteListReducer = NoteListReducer()
    ) {
        self.noteListTabsViewModel = noteListTabsViewModel

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
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            let newState = self.reducer.reduce(currentState: state, intent: intent)
            self.state = newState

            if case .loaded(let noteList) = newState, let newTags = noteList.tags {
                self.noteListTabsViewModel.tags = newTags
            }
        }
    }
}
