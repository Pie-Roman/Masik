//
//  NoteTagNetworkDto.swift
//  Masik
//
//  Created by Роман Ломтев on 01.08.2025.
//

struct NoteTagNetworkDto: Identifiable, Codable {
    let name: String?
    let color: String?
    
    var id: String {
        return name ?? ""
    }
}
