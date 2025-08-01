//
//  NoteEntryTagListIntent.swift
//  Masik
//
//  Created by Роман Ломтев on 02.08.2025.
//

enum NoteEntryTagListIntent {
    case load
    case showLoading
    case showLoaded([NoteTag])
    case showAdded(tag: NoteTag)
}
