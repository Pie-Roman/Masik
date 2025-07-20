//
//  NoteActionsView.swift
//  Masik
//
//  Created by Роман Ломтев on 06.07.2025.
//

import SwiftUI

struct NoteActionsView: View {
    
    let note: Note
    let onUpdateTap: () -> Void
    let onDeleteTap: () -> Void
    let onCancelTap: () -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            VStack(spacing: 0) {
                
                Button(action: {
                    onUpdateTap()
                }) {
                    Text("Редактировать")
                        .font(.body)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                }
                
                Divider()
                
                Button(action: {
                    onDeleteTap()
                }) {
                    Text("Удалить")
                        .font(.body)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                }
            }
            .background(Color(.systemGray6))
            .cornerRadius(12)
            
            Button(action: {
                onCancelTap()
            }) {
                Text("Отмена")
                    .font(.headline)
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
            }
            .background(Color(.systemBackground))
            .cornerRadius(12)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
    }
}
