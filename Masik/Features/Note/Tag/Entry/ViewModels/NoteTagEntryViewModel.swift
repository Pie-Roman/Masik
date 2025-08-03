//
//  NoteTagEntryViewModel.swift
//  Masik
//
//  Created by Роман Ломтев on 01.08.2025.
//

import SwiftUI

final class NoteTagEntryViewModel: ObservableObject {
    
    @Published private(set) var state: NoteTagEntryState = .idle

    @Published var name: String
    @Published var color: String

    private let processor: NoteTagEntryProcessor
    private let reducer: NoteTagEntryReducer

    init(
        initialData: NoteTagEntryInitialData,
        interactor: NoteTagEntryInteractor = NoteTagEntryInteractor(),
        reducer: NoteTagEntryReducer = NoteTagEntryReducer()
    ) {
        self.name = initialData.tag?.name ?? ""
        self.color = initialData.tag?.color ?? ""

        self.processor = NoteTagEntryProcessor(interactor: interactor)
        self.reducer = reducer
        self.processor.handler = self
    }
    
    func send(intent: Intent) {
        processor.process(intent: intent)
    }
}

extension NoteTagEntryViewModel: NoteTagEntryHandler {
    
    func handle(intent: NoteTagEntryIntent) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            let newState = self.reducer.reduce(currentState: state, intent: intent)
            self.state = newState
        }
    }
}
