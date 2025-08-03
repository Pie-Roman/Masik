import SwiftUI

struct NoteTagEntryView: View {

    let initialData: NoteTagEntryInitialData

    let onAdded: ((NoteTag) -> Void)?
    let onUpdated: ((NoteTag) -> Void)?
    let onCancelled: () -> Void
    
    @State private var red: Double = 255
    @State private var green: Double = 165
    @State private var blue: Double = 0

    private var color: Color {
        Color(red: red / 255, green: green / 255, blue: blue / 255)
    }
    
    @StateObject private var viewModel: NoteTagEntryViewModel

    init(
        initialData: NoteTagEntryInitialData,
        onAdded: ((NoteTag) -> Void)?,
        onUpdated: ((NoteTag) -> Void)?,
        onCancelled: @escaping () -> Void,
    ) {
        self.initialData = initialData

        self.onAdded = onAdded
        self.onUpdated = onUpdated
        self.onCancelled = onCancelled

        self._viewModel = StateObject(
            wrappedValue: NoteTagEntryViewModel(
                initialData: initialData
            )
        )
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    Group {

                        TextField("Название", text: $viewModel.name)
                            .padding(.horizontal, 16)
                            .fontWeight(.semibold)
                            .frame(height: 80)
                            .background(Color(UIColor.systemGray5))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                        
                        VStack(spacing: 8) {
                            
                            Text("Цвет")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(Color(UIColor.placeholderText))
                            
                            RoundedRectangle(cornerRadius: 12)
                                .fill(color)
                                .frame(height: 40)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.secondary.opacity(0.3), lineWidth: 1)
                                )

                            RGBSliderView(label: "R", value: $red, tint: .red)
                            RGBSliderView(label: "G", value: $green, tint: .green)
                            RGBSliderView(label: "B", value: $blue, tint: .blue)
                        }
                        .padding()
                        .background(Color(UIColor.systemGray5))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }
                .padding()
            }
            .navigationTitle(navigationTitle())
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
                        if !viewModel.name.isEmpty {
                            let r = Int(red)
                            let g = Int(green)
                            let b = Int(blue)
                            let color = String(format: "#%02X%02X%02X", r, g, b)
                            let tag = NoteTag(
                                id: "",
                                name: viewModel.name,
                                color: color
                            )

                            switch initialData.mode {
                            case .add:
                                viewModel.send(intent: .add(tag: tag))
                            case .update:
                                if let initialTag = initialData.tag {
                                    viewModel.send(intent: .update(id: initialTag.id, tag: tag))
                                }
                            }
                        }
                    }
                    .fontWeight(.semibold)
                    .disabled(viewModel.name.isEmpty)
                }
            }
            .onReceive(viewModel.$state) { state in
                switch state {

                case .added(let tag):
                    onAdded?(tag)

                case .updated(let tag):
                    onUpdated?(tag)

                default:
                    break
                }
            }
        }
    }

    private func navigationTitle() -> String {
        if initialData.mode == .add {
            return "Добавить тег"
        } else {
            return "Изменить тег"
        }
    }
}

