//
//  NoteTagNetworkMapper.swift
//  Masik
//
//  Created by Роман Ломтев on 01.08.2025.
//

import Foundation

class NoteTagNetworkMapper {
    
    func map(dto: NoteTagNetworkDto) -> NoteTag {
        let name = dto.name ?? ""
        let color = dto.color ?? ""
        
        return NoteTag(
            name: name,
            color: color
        )
    }
    
    func map(model: NoteTag) -> NoteTagNetworkDto {
        let name = model.name
        let color = model.color
        
        return NoteTagNetworkDto(
            name: name,
            color: color
        )
    }
}
