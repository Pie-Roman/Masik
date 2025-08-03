//
//  NoteTagEntryIntent.swift
//  Masik
//
//  Created by Роман Ломтев on 01.08.2025.
//

enum NoteTagEntryIntent {
    
    case add(tag: NoteTag)
    case showAdded(tag: NoteTag)

    case update(id: String, tag: NoteTag)
    case showUpdated(tag: NoteTag)
}
