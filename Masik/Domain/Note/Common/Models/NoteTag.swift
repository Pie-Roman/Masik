//
//  NoteTag.swift
//  Masik
//
//  Created by Роман Ломтев on 01.08.2025.
//

struct NoteTag: Identifiable, Hashable {
    let name: String
    let color: String
    
    var id: String {
        return name
    }
}
