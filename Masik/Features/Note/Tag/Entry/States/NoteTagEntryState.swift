//
//  NoteTagEntryState.swift
//  Masik
//
//  Created by Роман Ломтев on 01.08.2025.
//

enum NoteTagEntryState {
    case idle
    case added(tag: NoteTag)
    case updated(tag: NoteTag)
}
