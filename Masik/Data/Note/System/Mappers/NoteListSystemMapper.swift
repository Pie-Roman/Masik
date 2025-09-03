//
//  NoteListSystemMapper.swift
//  Masik
//
//  Created by Роман Ломтев on 03.09.2025.
//

import EventKit

class NoteListSystemMapper {
    
    private let noteSystemMapper = NoteSystemMapper()
    
    func map(events: [EKEvent]) -> NoteList {
        let tags: [NoteTag] = []
        let items = events.map { noteSystemMapper.map(event: $0) }
        
        return NoteList(
            tags: tags,
            items: items
        )
    }
}
