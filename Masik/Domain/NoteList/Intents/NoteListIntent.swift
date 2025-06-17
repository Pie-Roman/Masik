//
//  NoteListIntent.swift
//  Masik
//
//  Created by Roman Lomtev on 17.06.2025.
//

enum NoteListIntent {
    case load
    case add(body: NoteBody)
    case delete(id: String)
    case toggleDone(id: String, isDone: Bool)
    case showError(String)
}
