//
//  NoteListViewModel.swift
//  Masik
//
//  Created by Roman Lomtev on 17.06.2025.
//

import SwiftUI

class NotesListViewModel: ObservableObject {
    @Published var notes: [Note] = []

    func addNote(title: String) {
        let newNote = Note(title: title)
        notes.append(newNote)
    }

    func toggleDone(note: Note) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index].isDone.toggle()
        }
    }

    func removeNote(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
    }
}
