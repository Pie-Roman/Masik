//
//  NoteEntryInitialData.swift
//  Masik
//
//  Created by Роман Ломтев on 20.07.2025.
//

import Foundation

struct NoteEntryInitialData: Identifiable {
    let mode: NoteEntryMode
    let note: Note?
    
    var id: String {
        let noteID = note?.id ?? "nil"
        return "\(mode)-\(noteID)"
    }
}
