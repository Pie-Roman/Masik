//
//  NoteBodyNetworkMapper.swift
//  Masik
//
//  Created by Roman Lomtev on 17.06.2025.
//

class NoteBodyNetworkMapper {

    func map(dto: NoteBodyNetworkDto?) -> NoteBody {
        let title = dto?.title ?? ""
        let isDone = dto?.isDone ?? false

        return NoteBody(
            title: title,
            isDone: isDone
        )
    }

    func map(model: NoteBody) -> NoteBodyNetworkDto {
        let title = model.title
        let isDone = model.isDone

        return NoteBodyNetworkDto(
            title: title,
            isDone: isDone
        )
    }
}
