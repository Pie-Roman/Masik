//
//  NoteListNetworkMapper.swift
//  Masik
//
//  Created by Roman Lomtev on 17.06.2025.
//

class NoteListNetworkMapper {

    private let noteNetworkMapper = NoteNetworkMapper()
    private let noteTagNetworkMapper = NoteTagNetworkMapper()

    func map(dto: NoteListNetworkDto) throws -> NoteList {
        let tags = try dto.tags?.map { tag in
            try noteTagNetworkMapper.map(dto: tag)
        }
        let items = try dto.items?.map { item in
            try noteNetworkMapper.map(dto: item)
        } ?? []

        return NoteList(
            tags: tags,
            items: items
        )
    }
}
