//
//  NoteActionsView.swift
//  Masik
//
//  Created by Роман Ломтев on 06.07.2025.
//

import SwiftUI

struct NoteActionsView: View {
    
    let id: String
    let onDeleteTap: () -> Void
    
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            VStack(spacing: 0) {
                
                Button(action: {
                    isPresented = false
                }) {
                    Text("Редактировать")
                        .font(.body)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                }
                
                Divider()
                
                Button(action: {
                    isPresented = false
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
                isPresented = false
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
