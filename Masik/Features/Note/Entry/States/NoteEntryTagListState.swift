//
//  NoteEntryTagListState.swift
//  Masik
//
//  Created by Роман Ломтев on 02.08.2025.
//

enum NoteEntryTagListState {
    case idle
    case loading(tags: [NoteTag])
    case loaded(tags: [NoteTag])
}
