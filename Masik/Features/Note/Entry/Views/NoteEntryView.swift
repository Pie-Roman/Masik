import SwiftUI

struct NoteEntryView: View {

    let initialData: NoteEntryInitialData
    let onAdded: ((Note) -> Void)?
    let onUpdated: ((Note) -> Void)?
    let onCancelled: () -> Void
    
    @StateObject private var viewModel: NoteEntryViewModel
    @StateObject private var tagListViewModel = NoteEntryTagListViewModel()

    init(
        initialData: NoteEntryInitialData,
        onCancelled: @escaping () -> Void,
        onAdded: ((Note) -> Void)? = nil,
        onUpdated: ((Note) -> Void)? = nil
    ) {
        self.initialData = initialData
        self.onCancelled = onCancelled
        self.onAdded = onAdded
        self.onUpdated = onUpdated
        
        self._viewModel = StateObject(
            wrappedValue: NoteEntryViewModel(
                initialData: initialData
            )
        )
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {

                    HStack {
                        Button(action: {
                            // выбрать фото
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color(UIColor.systemGray5))
                                    .frame(width: UIScreen.main.bounds.width / 2, height: 80)
                                Image(systemName: "camera")
                                    .font(.system(size: 24, weight: .medium))
                                    .foregroundColor(.black)
                            }
                        }
                        Spacer()
                    }

                    Group {

                        TextField("Заметка", text: Binding(
                            get: { viewModel.title },
                            set: { viewModel.title = $0 }
                        ))
                            .padding(.horizontal, 16)
                            .fontWeight(.semibold)
                            .frame(height: 80)
                            .background(Color(UIColor.systemGray5))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                        
                        HStack {
                            TextField("Ссылка", text: Binding(
                                get: { viewModel.link },
                                set: { viewModel.link = $0 }
                            ))
                                .padding(.leading, 16)
                                .fontWeight(.semibold)
                            Image(systemName: "sparkles")
                                .font(.system(size: 24))
                                .padding(.trailing, 16)
                                .foregroundColor(.black)
                        }
                        .frame(height: 80)
                        .background(Color(UIColor.systemGray5))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }

                    NoteEntryTagListView(
                        viewModel: tagListViewModel
                    )
                }
                .padding()
            }
            .navigationTitle("Что надо сделать")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") {
                        onCancelled()
                    }
                    .foregroundColor(.blue)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Готово") {
                        if !viewModel.title.isEmpty {
                            let body = NoteBody(
                                title: viewModel.title,
                                isDone: false,
                                tags: Set(tagListViewModel.tags),
                            )

                            switch initialData.mode {
                            case .add:
                                viewModel.send(intent: .add(body: body))
                            case .update:
                                if let note = initialData.note {
                                    viewModel.send(intent: .update(id: note.id, body: body))
                                }
                            }
                        }
                    }
                    .fontWeight(.semibold)
                    .disabled(viewModel.title.isEmpty)
                }
            }
            .onReceive(viewModel.$state) { state in
                switch state {
                case .added(let note):
                    onAdded?(note)
                case .updated(let note):
                    onUpdated?(note)
                default:
                    break
                }
            }
        }
    }
}

