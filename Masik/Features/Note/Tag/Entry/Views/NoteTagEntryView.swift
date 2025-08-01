import SwiftUI

struct NoteTagEntryView: View {

    let onAdded: (NoteTag) -> Void
    let onCancelled: () -> Void
    
    @State private var name: String = ""
    @State private var color: String = ""
    
    @StateObject private var viewModel: NoteTagEntryViewModel = NoteTagEntryViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    Group {

                        TextField("Название", text: $name)
                            .padding(.horizontal, 16)
                            .fontWeight(.semibold)
                            .frame(height: 80)
                            .background(Color(UIColor.systemGray5))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                        
                        TextField("Цвет", text: $color)
                            .padding(.leading, 16)
                            .fontWeight(.semibold)
                            .frame(height: 80)
                            .background(Color(UIColor.systemGray5))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }
                .padding()
            }
            .navigationTitle("Добавить тег")
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
                        if !name.isEmpty {
                            let tag = NoteTag(
                                name: name,
                                color: color
                            )

                            viewModel.send(intent: .add(tag: tag))
                        }
                    }
                    .fontWeight(.semibold)
                    .disabled(name.isEmpty)
                }
            }
            .onReceive(viewModel.$state) { state in
                switch state {
                case .added(let tag):
                    onAdded(tag)
                default:
                    break
                }
            }
        }
    }
}

