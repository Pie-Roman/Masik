//
//  NoteListInteractor.swift
//  Masik
//
//  Created by Roman Lomtev on 17.06.2025.
//

class NoteListInteractor {

    private let networkWorker = NoteNetworkWorker()
    private let systemWorker = NoteSystemWorker()

    func requestSystemEventsPermission(completion: @escaping (Bool) -> Void) {
        systemWorker.requestAccess(completion: completion)
    }

    func launch(
        withSystemNotes: Bool
    ) async throws {
        if withSystemNotes {
            let systemNotes: [Note] = try await systemWorker.fetchAll()
            try await networkWorker.launch(systemNotes: systemNotes)
        }
    }

    func loadNoteList(
        tagId: String? = nil
    ) async throws -> NoteList {
        try await networkWorker.fetchAll(
            tagId: tagId
        )
    }

    func addNote(noteBody: NoteBody) async throws -> Note {
        try await networkWorker.add(noteBody: noteBody)
    }

    func deleteNote(id: String) async throws {
        try await networkWorker.delete(id: id)
    }
}
