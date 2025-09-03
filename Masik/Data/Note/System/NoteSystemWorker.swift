//
//  NoteSystemWorket.swift
//  Masik
//
//  Created by Роман Ломтев on 03.09.2025.
//

import Foundation
import EventKit

class NoteSystemWorker {
    
    private let store = EKEventStore()
    private let noteListSystemMapper = NoteListSystemMapper()
    
    func requestAccess(completion: @escaping (Bool) -> Void) {
        if #available(iOS 17, *) {
            store.requestFullAccessToEvents { granted, error in
                completion(granted)
            }
        } else {
            store.requestAccess(to: .event) { granted, error in
                completion(granted)
            }
        }
    }
    
    func fetchAll() async throws -> NoteList {
        let endDate = Date()
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: endDate)!
        let events = fetchEvents(from: startDate, to: endDate)
        
        return noteListSystemMapper.map(events: events)
    }
    
    private func fetchEvents(from startDate: Date, to endDate: Date) -> [EKEvent] {
        let calendars = store.calendars(for: .event)
        let predicate = store.predicateForEvents(withStart: startDate, end: endDate, calendars: calendars)
        return store.events(matching: predicate)
    }
}
