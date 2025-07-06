//
//  NoteActionsInteractor.swift
//  Masik
//
//  Created by Роман Ломтев on 07.07.2025.
//

class NoteActionsInteractor {

    private let worker = NoteNetworkWorker()

    func deleteNote(id: String) async throws {
        try await worker.delete(id: id)
    }
}

