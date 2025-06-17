//
//  NoteListView.swift
//  Masik
//
//  Created by Roman Lomtev on 17.06.2025.
//

import SwiftUI

struct NoteListView: View {
    @StateObject private var viewModel = NoteListViewModel()
    @State private var showingAdd = false
    @State private var newNoteTitle = ""
    @State private var isFirstAppear = true

    var body: some View {
        NavigationView {
            Group {
                switch viewModel.state {
                case .idle:
                    Color.clear
                        .onAppear {
                            if isFirstAppear {
                                isFirstAppear = false
                                viewModel.send(.load)
                            }
                        }

                case .loading:
                    VStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }

                case .loaded(let noteList):
                    if noteList.items.isEmpty {
                        VStack(spacing: 24) {
                            Spacer()
                            Text("Список дел пуст")
                                .foregroundColor(.gray)
                                .font(.title3)
                            Spacer()
                        }
                    } else {
                        List {
                            ForEach(noteList.items) { note in
                                HStack {
                                    Image(systemName: note.body.isDone ? "checkmark.circle.fill" : "circle")
                                        .onTapGesture {
                                            viewModel.send(.toggleDone(id: note.id, isDone: !note.body.isDone))
                                        }
                                    Text(note.body.title)
                                        .strikethrough(note.body.isDone)
                                    Spacer()
                                }
                            }
                            .onDelete { indexSet in
                                for index in indexSet {
                                    if case let .loaded(noteList) = viewModel.state {
                                        let items = noteList.items
                                        if items.indices.contains(index) {
                                            let id = items[index].id
                                            viewModel.send(.delete(id: id))
                                        }
                                    }
                                }
                            }
                        }
                    }

                case .error(let message):
                    VStack(spacing: 16) {
                        Spacer()
                        Image(systemName: "exclamationmark.triangle.fill")
                            .resizable()
                            .frame(width: 48, height: 48)
                            .foregroundColor(.red)
                        Text("Ошибка")
                            .font(.title2)
                        Text(message)
                            .foregroundColor(.red)
                        Button("Попробовать снова") {
                            viewModel.send(.load)
                        }
                        Spacer()
                    }
                }
            }
            .navigationTitle("Что надо сделать")
            .toolbar {
                if case .loaded = viewModel.state {
                    Button {
                        showingAdd = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAdd) {
                NavigationView {
                    Form {
                        TextField("Заметка", text: $newNoteTitle)
                    }
                    .navigationTitle("Добавить дело")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Отмена") {
                                showingAdd = false
                                newNoteTitle = ""
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Сохранить") {
                                if !newNoteTitle.isEmpty {
                                    let body = NoteBody(title: newNoteTitle, isDone: false)
                                    viewModel.send(.add(body: body))
                                    showingAdd = false
                                    newNoteTitle = ""
                                }
                            }
                            .disabled(newNoteTitle.isEmpty)
                        }
                    }
                }
            }
        }
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
