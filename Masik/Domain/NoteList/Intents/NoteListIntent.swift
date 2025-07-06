//
//  NoteListIntent.swift
//  Masik
//
//  Created by Roman Lomtev on 17.06.2025.
//

enum NoteListIntent {
    
    case load
    case showLoading
    case showLoaded(NoteList)
    
    case add(body: NoteBody)
    case showAdded(Note)
    
    case delete(id: String)
    case showDeleted(id: String)
    
    case toggleDone(id: String, isDone: Bool)
    case showToggledDone(id: String, isDone: Bool)
    
    case showError(String)
}
