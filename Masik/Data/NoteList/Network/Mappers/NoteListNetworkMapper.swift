//
//  NoteListNetworkMapper.swift
//  Masik
//
//  Created by Roman Lomtev on 17.06.2025.
//

class NoteListNetworkMapper {

    private let noteNetworkMapper = NoteNetworkMapper()

    func map(dto: NoteListNetworkDto) throws -> NoteList {
        let items = try dto.items?.map { item in
            try noteNetworkMapper.map(dto: item)
        } ?? []

        return NoteList(
            items: items
        )
    }
}
