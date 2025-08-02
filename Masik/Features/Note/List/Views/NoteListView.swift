import SwiftUI

struct NoteListView: View {
    @StateObject private var viewModel = NoteListViewModel()
    
    @State private var noteEntryData: NoteEntryInitialData? = nil

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
                        noteEntryData = NoteEntryInitialData(
                            mode: .add,
                            note: nil
                        )
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(item: $noteEntryData) { item in
                NoteEntryView(
                    initialData: item,
                    onCancelled: {
                        noteEntryData = nil
                    },
                    onAdded: { note in
                        viewModel.send(intent: .showLoading)
                        viewModel.send(intent: .showAdded(note))
                        noteEntryData = nil
                    },
                    onUpdated: { note in
                        viewModel.send(intent: .showLoading)
                        viewModel.send(intent: .showUpdated(note))
                        noteEntryData = nil
                    }
                )
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
        VStack {
            
            ScrollView(.horizontal) {
                HStack(alignment: .top) {
                    ForEach(noteList.tags, id: \.name) { tag in
                        Text(tag.name)
                    }
                }
            }
            .padding(.top, 8)
            
            if noteList.items.isEmpty {
                VStack(spacing: 12) {
                    Spacer()
                    Text("Список дел пуст")
                        .foregroundColor(.gray)
                        .font(.title3)
                    Spacer()
                }
            } else {
                ScrollView {
                    HStack(alignment: .top) {

                        VStack(spacing: 12) {
                            ForEach(noteList.items.enumerated().filter { $0.offset % 2 == 0 }, id: \.element.id) { index, note in
                                noteListItemView(note: note, index: index)
                            }
                        }

                        VStack(spacing: 12) {
                            ForEach(noteList.items.enumerated().filter { $0.offset % 2 != 0 }, id: \.element.id) { index, note in
                                noteListItemView(note: note, index: index)
                            }
                        }
                    }
                    .padding(.top)
                }
            }
        }
        .padding(.horizontal)
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
    
    @ViewBuilder
    private func noteListItemView(note: Note, index: Int) -> some View {
        NoteListItemView(
            note: note,
            heightOffset: index % 3,
            onUpdateTap: {
                noteEntryData = NoteEntryInitialData(mode: .update, note: note)
            },
            onDeleteTap: {
                viewModel.send(intent: .delete(id: note.id))
            }
        )
    }
}
