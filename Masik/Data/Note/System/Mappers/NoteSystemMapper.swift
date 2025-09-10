//
//  NoteBodySystemMapper.swift
//  Masik
//
//  Created by Роман Ломтев on 03.09.2025.
//

import EventKit

class NoteSystemMapper {
    
    func map(event: EKEvent) -> Note {
        let id = "iOS-\(event.eventIdentifier ?? UUID().uuidString)"
        let tag = NoteTag(
            id: event.calendar.calendarIdentifier,
            name: event.calendar.title,
            color: event.calendar.cgColor?.toHex() ?? "#999999"
        )
        let body = NoteBody(
            title: event.title ?? "Без названия",
            isDone: false,
            tags: [tag]
        )
        
        return Note(
            id: id,
            body: body
        )
    }
}
