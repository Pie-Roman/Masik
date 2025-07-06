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
                    // Левая колонка
                    VStack(spacing: 12) {
                        ForEach(noteList.items.enumerated().filter { $0.offset % 2 == 0 }, id: \.element.id) { index, note in
                            NoteCard(note: note, heightOffset: index % 3) {
                                viewModel.send(intent: .toggleDone(id: note.id, isDone: !note.body.isDone))
                            }
                        }
                    }

                    // Правая колонка
                    VStack(spacing: 12) {
                        ForEach(noteList.items.enumerated().filter { $0.offset % 2 != 0 }, id: \.element.id) { index, note in
                            NoteCard(note: note, heightOffset: index % 3) {
                                viewModel.send(intent: .toggleDone(id: note.id, isDone: !note.body.isDone))
                            }
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

    private func randomSoftColor() -> Color {
        let colors: [Color] = [
            Color(red: 0.93, green: 0.90, blue: 1.0), // soft purple
            Color(red: 1.0, green: 0.93, blue: 0.95), // soft pink
            Color(red: 1.0, green: 0.97, blue: 0.90), // soft orange
            Color(red: 0.90, green: 1.0, blue: 0.95), // mint
            Color(red: 1.0, green: 0.98, blue: 0.85), // soft yellow
            Color(red: 0.85, green: 0.95, blue: 1.0)  // light blue
        ]
        return colors.randomElement() ?? .gray
    }
}

struct NoteCard: View {
    let note: Note
    let heightOffset: Int
    var onTap: () -> Void

    var body: some View {
        Text(note.body.title)
            .font(.headline)
            .foregroundColor(.black)
            .padding()
            .frame(
                maxWidth: .infinity,
                minHeight: CGFloat(120 + heightOffset * 40),
                alignment: .bottomLeading
            )
            .background(randomSoftColor())
            .cornerRadius(24)
            .onTapGesture {
                onTap()
            }
    }

    private func randomSoftColor() -> Color {
        let colors: [Color] = [
            Color(red: 0.93, green: 0.90, blue: 1.0),
            Color(red: 1.0, green: 0.93, blue: 0.95),
            Color(red: 1.0, green: 0.97, blue: 0.90),
            Color(red: 0.90, green: 1.0, blue: 0.95),
            Color(red: 1.0, green: 0.98, blue: 0.85),
            Color(red: 0.85, green: 0.95, blue: 1.0)
        ]
        return colors.randomElement() ?? .gray
    }
}
