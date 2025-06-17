//
//  NoteNetworkMapper.swift
//  Masik
//
//  Created by Roman Lomtev on 17.06.2025.
//

import Foundation

class NoteNetworkMapper {

    private let noteBodyNetworkMapper = NoteBodyNetworkMapper()

    func map(dto: NoteNetworkDto) throws -> Note {
        guard let id = dto.id else {
            throw NSError(domain: "", code: 1, userInfo: nil)
        }
        let body = noteBodyNetworkMapper.map(dto: dto.body)

        return Note(
            id: id,
            body: body,
        )
    }
}
