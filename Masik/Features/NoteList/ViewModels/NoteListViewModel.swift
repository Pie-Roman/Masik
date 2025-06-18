//
//  NoteListViewModel.swift
//  Masik
//
//  Created by Roman Lomtev on 17.06.2025.
//

import SwiftUI
import Foundation

@MainActor
final class NoteListViewModel: ObservableObject {
    @Published private(set) var state: NoteListState = .idle
    private let processor: NoteListProcessor
    private var isFirstLoad = true

    init(interactor: NoteListInteractor = NoteListInteractor()) {
        self.processor = NoteListProcessor(interactor: interactor)
        send(.load)
    }

    func send(_ intent: NoteListIntent) {
        Task {
            let newState = await processor.process(currentState: state, intent: intent)
            state = newState
        }
    }
}
