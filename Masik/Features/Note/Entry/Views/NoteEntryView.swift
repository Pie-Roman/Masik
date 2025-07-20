//
//  NoteEntryView.swift
//  Masik
//
//  Created by Роман Ломтев on 19.07.2025.
//

import SwiftUI

struct NoteEntryView: View {
    
    let initialData: NoteEntryInitialData
    
    let onAdded: ((Note) -> Void)?
    let onUpdated: ((Note) -> Void)?
    let onCancelled: () -> Void
    
    @State private var title: String
    
    @StateObject private var viewModel: NoteEntryViewModel = NoteEntryViewModel()
    
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
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Заметка", text: $title)
            }
            .navigationTitle("Добавить дело")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") {
                        onCancelled()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Сохранить") {
                        if !title.isEmpty {
                            let body = NoteBody(title: title, isDone: false)
                            
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
}
