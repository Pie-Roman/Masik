//
//  NoteTagEntryInteractor.swift
//  Masik
//
//  Created by Роман Ломтев on 01.08.2025.
//

class NoteTagEntryInteractor {

    private let worker = NoteNetworkWorker()

    func addTag(tag: NoteTag) async throws -> NoteTag {
        try await worker.addTag(tag: tag)
    }
}
