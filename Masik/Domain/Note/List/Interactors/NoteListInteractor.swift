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

    func loadNoteList(
        withSystemNotes: Bool
    ) async throws -> NoteList {
        let networkNotes = try await networkWorker.fetchAll()
        
        if withSystemNotes {
            let systemNotes: NoteList = try await systemWorker.fetchAll()
            return NoteList(
                tags: networkNotes.tags + systemNotes.tags,
                items: networkNotes.items + systemNotes.items
            )
        } else {
            return networkNotes
        }
    }

    func addNote(noteBody: NoteBody) async throws -> Note {
        try await networkWorker.add(noteBody: noteBody)
    }

    func deleteNote(id: String) async throws {
        try await networkWorker.delete(id: id)
    }
}
