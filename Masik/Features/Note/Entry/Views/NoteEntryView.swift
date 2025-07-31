import SwiftUI

struct NoteEntryView: View {

    let initialData: NoteEntryInitialData
    let onAdded: ((Note) -> Void)?
    let onUpdated: ((Note) -> Void)?
    let onCancelled: () -> Void
    
    @State private var link: String = ""
    @State private var title: String
    
    @StateObject private var viewModel: NoteEntryViewModel = NoteEntryViewModel()

    @State private var tags: [NoteTag]

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

        self.title = initialData.note?.body.title ?? ""
        self.tags = Array(initialData.note?.body.tags ?? Set())
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

                        TextField("Заметка", text: $title)
                            .padding(.horizontal, 16)
                            .fontWeight(.semibold)
                            .frame(height: 80)
                            .background(Color(UIColor.systemGray5))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                        
                        HStack {
                            TextField("Ссылка", text: $link)
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

                    noteTagsView()
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
                        if !title.isEmpty {
                            let body = NoteBody(
                                title: title,
                                isDone: false,
                                tags: Set(tags),
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
                    .disabled(title.isEmpty)
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
    
    @ViewBuilder
    private func noteTagsView() -> some View {
        VStack(spacing: 8) {
            HStack {
                Text("Теги")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.gray)
                Spacer()
                Button(action: {
                    // добавить новый список
                }) {
                    Text("Новый тег")
                        .font(.system(size: 17, weight: .semibold))
                }
            }
            .padding(.horizontal, 4)

            VStack(spacing: 8) {
                ForEach(tags, id: \.self) { tag in
                    HStack {
                        Image(systemName: "list.bullet.rectangle")
                        Text(tag.name)
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .frame(height: 52)
                    .background(Color(UIColor.systemGray5))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
        }
    }
}

