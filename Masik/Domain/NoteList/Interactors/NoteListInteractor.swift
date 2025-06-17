//
//  NoteListInteractor.swift
//  Masik
//
//  Created by Roman Lomtev on 17.06.2025.
//

protocol NoteListInteractable {

    func loadNotes() async throws -> NoteList

    func addNote(noteBody: NoteBody) async throws -> Note

    func deleteNote(id: String) async throws

    func toggleDone(id: String, isDone: Bool) async throws -> Note
}

class NoteListInteractor: NoteListInteractable {

    private let worker = NoteListNetworkWorker()

    func loadNotes() async throws -> NoteList {
        try await worker.fetchAll()
    }

    func addNote(noteBody: NoteBody) async throws -> Note {
        try await worker.add(noteBody: noteBody)
    }

    func deleteNote(id: String) async throws {
        try await worker.delete(id: id)
    }

    func toggleDone(id: String, isDone: Bool) async throws -> Note {
        try await worker.updateIsDone(id: id, isDone: isDone)
    }
}
