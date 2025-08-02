import SwiftUI

struct NoteTagEntryView: View {

    let onAdded: (NoteTag) -> Void
    let onCancelled: () -> Void
    
    @State private var name: String = ""
    
    @State private var red: Double = 255
    @State private var green: Double = 165
    @State private var blue: Double = 0

    private var color: Color {
        Color(red: red / 255, green: green / 255, blue: blue / 255)
    }
    
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
                        .onChange(of: red) { updateHexColor() }
                        .onChange(of: green) { updateHexColor() }
                        .onChange(of: blue) { updateHexColor() }
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
                            let r = Int(red)
                            let g = Int(green)
                            let b = Int(blue)
                            let color = String(format: "#%02X%02X%02X", r, g, b)
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
    
    private func updateHexColor() {
        
    }
}

