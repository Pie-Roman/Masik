import SwiftUI

struct NoteListView: View {
    @StateObject private var viewModel = NoteListViewModel()
    @State private var showingAdd = false
    @State private var newNoteTitle = ""

    var body: some View {
        NavigationView {
            Group {
                switch viewModel.state {
                case .idle:
                    idleView()

                case .loading:
                    loadingView()

                case .loaded(let noteList):
                    loadedView(noteList)

                case .error(let message):
                    errorView(message)
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
                                    viewModel.send(intent: .add(body: body))
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
    
    @ViewBuilder
    private func idleView() -> some View {
        Color.clear
            .onAppear {
                viewModel.send(intent: .load)
            }
    }
    
    @ViewBuilder
    private func loadingView() -> some View {
        VStack {
            Spacer()
            ProgressView()
            Spacer()
        }
    }
    
    @ViewBuilder
    private func loadedView(_ noteList: NoteList) -> some View {
        if noteList.items.isEmpty {
            VStack(spacing: 24) {
                Spacer()
                Text("Список дел пуст")
                    .foregroundColor(.gray)
                    .font(.title3)
                Spacer()
            }
        } else {
            ScrollView {
                HStack(alignment: .top, spacing: 12) {

                    VStack(spacing: 12) {
                        ForEach(noteList.items.enumerated().filter { $0.offset % 2 == 0 }, id: \.element.id) { index, note in
                            NoteView(
                                note: note,
                                heightOffset: index % 3,
                                onDeleted: {
                                    viewModel.send(intent: .delete(id: note.id))
                                }
                            )
                        }
                    }

                    VStack(spacing: 12) {
                        ForEach(noteList.items.enumerated().filter { $0.offset % 2 != 0 }, id: \.element.id) { index, note in
                            NoteView(
                                note: note,
                                heightOffset: index % 3,
                                onDeleted: {
                                    viewModel.send(intent: .delete(id: note.id))
                                }
                            )
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top)
            }
        }
    }
    
    @ViewBuilder
    private func errorView(_ message: String) -> some View {
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
                viewModel.send(intent: .load)
            }
            Spacer()
        }
    }
}
