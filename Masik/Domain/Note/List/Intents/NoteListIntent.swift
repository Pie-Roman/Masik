//
//  NoteListIntent.swift
//  Masik
//
//  Created by Roman Lomtev on 17.06.2025.
//

enum NoteListIntent {
    
    case launch
    
    case load
    case loadForTag(tagId: String)
    case showLoading
    case showLoaded(NoteList)
    
    case showAdded(Note)
    
    case showUpdated(Note)
    
    case delete(id: String)
    case showDeleted(id: String)

    case showError(String)
}
