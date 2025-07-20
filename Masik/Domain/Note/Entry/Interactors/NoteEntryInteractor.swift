//
//  NoteEntryInteractor.swift
//  Masik
//
//  Created by Роман Ломтев on 19.07.2025.
//

class NoteEntryInteractor {

    private let worker = NoteNetworkWorker()

    func addNote(noteBody: NoteBody) async throws -> Note {
        try await worker.add(noteBody: noteBody)
    }

    func updateNote(id: String, noteBody: NoteBody) async throws -> Note {
        try await worker.update(id: id, noteBody: noteBody)
    }
}
