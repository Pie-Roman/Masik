//
//  NoteEntryIntent.swift
//  Masik
//
//  Created by Роман Ломтев on 19.07.2025.
//

enum NoteEntryIntent {
    
    case add(body: NoteBody)
    case showAdded(note: Note)
    
    case update(id: String, body: NoteBody)
    case showUpdated(id: String, note: Note)
}
