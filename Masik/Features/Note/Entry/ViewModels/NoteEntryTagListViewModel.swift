//
//  NoteEntryTagListViewModel.swift
//  Masik
//
//  Created by Роман Ломтев on 02.08.2025.
//

import SwiftUI

final class NoteEntryTagListViewModel: ObservableObject {
    
    @Published private(set) var state: NoteEntryTagListState = .idle

    @Published var selectedTagIds: [String]

    private let processor: NoteEntryTagListProcessor
    private let reducer: NoteEntryTagListReducer

    init(
        initialData: NoteEntryTagListInitialData,
        interactor: NoteEntryTagListInteractor = NoteEntryTagListInteractor(),
        reducer: NoteEntryTagListReducer = NoteEntryTagListReducer()
    ) {
        self.selectedTagIds = initialData.note?.body.tags.map(\.id) ?? []

        self.processor = NoteEntryTagListProcessor(interactor: interactor)
        self.reducer = reducer
        self.processor.handler = self
    }
    
    func send(intent: Intent) {
        processor.process(intent: intent)
    }
}

extension NoteEntryTagListViewModel: NoteEntryTagListHandler {
    
    func handle(intent: NoteEntryTagListIntent) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            let newState = self.reducer.reduce(currentState: state, intent: intent)
            self.state = newState
        }
    }
}
