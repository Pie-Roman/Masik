//
//  NoteEntryTagListInteractor.swift
//  Masik
//
//  Created by Роман Ломтев on 02.08.2025.
//

class NoteEntryTagListInteractor {

    private let worker = NoteNetworkWorker()

    func loadTagList() async throws -> [NoteTag] {
        try await worker.fetchAllTags()
    }
}
