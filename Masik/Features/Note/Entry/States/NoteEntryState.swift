//
//  NoteEntryState.swift
//  Masik
//
//  Created by Роман Ломтев on 19.07.2025.
//

enum NoteEntryState {
    case idle
    case added(note: Note)
    case updated(note: Note)
}
