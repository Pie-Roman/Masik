//
//  NoteListState.swift
//  Masik
//
//  Created by Roman Lomtev on 17.06.2025.
//

enum NoteListState {
    case idle
    case loading(NoteList)
    case loaded(NoteList)
    case error(String)
}
