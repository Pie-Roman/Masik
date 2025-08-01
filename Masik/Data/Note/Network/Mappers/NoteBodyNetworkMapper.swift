//
//  NoteBodyNetworkMapper.swift
//  Masik
//
//  Created by Roman Lomtev on 17.06.2025.
//

class NoteBodyNetworkMapper {
    
    private let noteTagNetworkMapper = NoteTagNetworkMapper()

    func map(dto: NoteBodyNetworkDto?) -> NoteBody {
        let title = dto?.title ?? ""
        let isDone = dto?.isDone ?? false
        let tags = Set((dto?.tags ?? []).compactMap { try? noteTagNetworkMapper.map(dto: $0) })

        return NoteBody(
            title: title,
            isDone: isDone,
            tags: tags
        )
    }

    func map(model: NoteBody) -> NoteBodyNetworkDto {
        let title = model.title
        let isDone = model.isDone
        let tags = model.tags.map(noteTagNetworkMapper.map)

        return NoteBodyNetworkDto(
            title: title,
            isDone: isDone,
            tags: tags
        )
    }
}
