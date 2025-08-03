//
//  NoteTagNetworkMapper.swift
//  Masik
//
//  Created by Роман Ломтев on 01.08.2025.
//

import Foundation

class NoteTagNetworkMapper {
    
    func map(dto: NoteTagNetworkDto) throws -> NoteTag {
        guard
            let id = dto.id,
            let name = dto.name,
            let color = dto.color
        else {
            throw NSError(domain: "", code: 1, userInfo: nil)
        }
        
        return NoteTag(
            id: id,
            name: name,
            color: color
        )
    }
    
    func map(model: NoteTag) -> NoteTagNetworkDto {
        let id = model.id
        let name = model.name
        let color = model.color
        
        return NoteTagNetworkDto(
            id: id,
            name: name,
            color: color
        )
    }
}
