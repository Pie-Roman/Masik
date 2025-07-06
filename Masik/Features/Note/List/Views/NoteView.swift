//
//  NoteView.swift
//  Masik
//
//  Created by Роман Ломтев on 06.07.2025.
//
import SwiftUI

struct NoteView: View {
    let note: Note
    let heightOffset: Int
    var onTap: () -> Void
    @State private var isActionsPresented = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Text(note.body.title)
                .font(.headline)
                .foregroundColor(.black)
                .padding()
                .frame(
                    maxWidth: .infinity,
                    minHeight: CGFloat(120 + heightOffset * 40),
                    alignment: .bottomLeading
                )
                .background(randomSoftColor())
                .cornerRadius(24)
                .onTapGesture {
                    onTap()
                }
            
            // Кнопка меню (многоточие)
            Button(action: {
                isActionsPresented = true
            }) {
                Image(systemName: "ellipsis")
                    .foregroundColor(.black.opacity(0.7))
                    .padding(12)
            }
        }
        .sheet(isPresented: $isActionsPresented) {
            NoteActionsView(id: note.id, isPresented: $isActionsPresented)
                .presentationBackground(.clear)
                .presentationDetents([.height(262)])
                .presentationDragIndicator(.hidden)
                .presentationCornerRadius(24)
        }
    }
    
    private func randomSoftColor() -> Color {
        let colors: [Color] = [
            Color(red: 0.93, green: 0.90, blue: 1.0),
            Color(red: 1.0, green: 0.93, blue: 0.95),
            Color(red: 1.0, green: 0.97, blue: 0.90),
            Color(red: 0.90, green: 1.0, blue: 0.95),
            Color(red: 1.0, green: 0.98, blue: 0.85),
            Color(red: 0.85, green: 0.95, blue: 1.0)
        ]
        return colors.randomElement() ?? .gray
    }
}
