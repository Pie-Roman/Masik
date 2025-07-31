//
//  NoteListInteractor.swift
//  Masik
//
//  Created by Roman Lomtev on 17.06.2025.
//

class NoteListInteractor {

    private let worker = NoteNetworkWorker()

    func loadNoteList() async throws -> NoteList {
        try await worker.fetchAll()
    }

    func addNote(noteBody: NoteBody) async throws -> Note {
        try await worker.add(noteBody: noteBody)
    }

    func deleteNote(id: String) async throws {
        try await worker.delete(id: id)
    }
}
