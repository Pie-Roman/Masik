//
//  NoteActionsView.swift
//  Masik
//
//  Created by Роман Ломтев on 06.07.2025.
//

import SwiftUI

struct NoteActionsView: View {
    
    let id: String
    
    @Binding var routeState: NoteActionsRouteState
    @StateObject var viewModel = NoteActionsViewModel()
    
    var body: some View {
        VStack(spacing: 8) {
            VStack(spacing: 0) {
                
                Button(action: {
                    viewModel.send(intent: .cancel)
                }) {
                    Text("Редактировать")
                        .font(.body)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                }
                
                Divider()
                
                Button(action: {
                    viewModel.send(intent: .delete(id: id))
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
                viewModel.send(intent: .cancel)
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
        .onChange(of: viewModel.state) { state in
            if state == .cancelled {
                routeState = .cancelled
            } else if state == .deleted {
                routeState = .deleted
            }
        }
    }
}
