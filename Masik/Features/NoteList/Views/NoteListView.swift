//
//  NoteListView.swift
//  Masik
//
//  Created by Roman Lomtev on 17.06.2025.
//

import SwiftUI

struct NoteListView: View {
    @StateObject private var viewModel = NotesListViewModel()
    @State private var showingAdd = false

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.notes) { note in
                    HStack {
                        Image(systemName: note.isDone ? "checkmark.circle.fill" : "circle")
                            .onTapGesture {
                                viewModel.toggleDone(note: note)
                            }
                        Text(note.title)
                            .strikethrough(note.isDone)
                        Spacer()
                        Text(note.dateCreated, style: .date)
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                }
                .onDelete(perform: viewModel.removeNote)
            }
            .navigationTitle("Что надо сделать")
            .toolbar {
                Button {
                    showingAdd = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAdd) {
                AddNoteView { title in
                    if !title.isEmpty {
                        viewModel.addNote(title: title)
                    }
                    showingAdd = false
                }
            }
        }
    }
}

struct AddNoteView: View {
    @State private var title = ""
    var onSave: (String) -> Void

    var body: some View {
        NavigationView {
            Form {
                TextField("Заметка", text: $title)
            }
            .navigationTitle("Добавить дело")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") {
                        onSave("")
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Сохранить") {
                        onSave(title)
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
}
