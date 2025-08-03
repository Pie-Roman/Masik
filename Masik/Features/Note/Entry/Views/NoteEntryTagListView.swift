//
//  NoteEntryTagListView.swift
//  Masik
//
//  Created by Роман Ломтев on 02.08.2025.
//

import SwiftUI

struct NoteEntryTagListView: View {

    @State private var tagEntryInitialData: NoteTagEntryInitialData? = nil

    @StateObject var viewModel: NoteEntryTagListViewModel
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Теги")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.gray)
                Spacer()
                Button(action: {
                    tagEntryInitialData = NoteTagEntryInitialData(
                        mode: .add,
                        tag: nil
                    )
                }) {
                    Text("Новый тег")
                        .font(.system(size: 17, weight: .semibold))
                }
            }
            .padding(.horizontal, 4)
            
            Group {
                switch viewModel.state {
                case .idle:
                    idleView()
                    
                case .loading:
                    loadingView()
                    
                case .loaded(let noteList):
                    loadedView(noteList)
                }
            }
        }
        .sheet(item: $tagEntryInitialData) { initialData in
            NoteTagEntryView(
                initialData: initialData,
                onAdded: { tag in
                    viewModel.send(intent: .showLoading)
                    viewModel.send(intent: .showAdded(tag: tag))
                    tagEntryInitialData = nil
                },
                onUpdated: { tag in
                    viewModel.send(intent: .showLoading)
                    viewModel.send(intent: .showUpdated(tag: tag))
                    tagEntryInitialData = nil
                },
                onCancelled: {
                    tagEntryInitialData = nil
                },
            )
        }
    }
    
    @ViewBuilder
    private func idleView() -> some View {
        Color.clear
            .onAppear {
                viewModel.send(intent: .load)
            }
    }
    
    @ViewBuilder
    private func loadingView() -> some View {
        VStack {
            Spacer()
            ProgressView()
            Spacer()
        }
    }
    
    @ViewBuilder
    private func loadedView(_ tags: [NoteTag]) -> some View {
        VStack {
            if tags.isEmpty {
                VStack(spacing: 16) {
                    Spacer(minLength: 64)
                    Image(systemName: "square.stack.3d.forward.dottedline")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 56, height: 56)
                        .foregroundColor(.gray)
                        .opacity(0.5)
                    Text("Создавайте списки и храните желания по темам или категориям.\nНапример: «Для ребёнка», «На новоселье» и т.п.")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .padding(.horizontal, 24)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 32)
            } else {
                VStack(spacing: 8) {
                    ForEach(tags, id: \.self) { tag in
                        tagListItemView(tag: tag)
                    }
                }
            }
        }
    }

    @ViewBuilder
    private func tagListItemView(tag: NoteTag) -> some View {
        HStack(spacing: 12) {
            Circle()
                .fill(Color(hex: tag.color) ?? .gray)
                .frame(width: 24, height: 24)
                .shadow(radius: 1)

            Text(tag.name)
                .font(.system(size: 17))

            Spacer()

            Image(systemName: viewModel.selectedTagIds.contains(tag.id) ? "checkmark.circle.fill" : "circle")
                .foregroundColor(viewModel.selectedTagIds.contains(tag.id) ? .blue : .gray)
        }
        .padding(.horizontal, 16)
        .frame(height: 52)
        .background(Color(UIColor.systemGray5))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .highPriorityGesture(
            LongPressGesture(minimumDuration: 0.5)
                .onEnded { _ in
                    tagEntryInitialData = NoteTagEntryInitialData(
                        mode: .update,
                        tag: tag
                    )
                }
        )
        .simultaneousGesture(
            TapGesture()
                .onEnded { _ in
                    if viewModel.selectedTagIds.contains(tag.id) {
                        viewModel.selectedTagIds.removeAll { $0 == tag.id }
                    } else {
                        viewModel.selectedTagIds.append(tag.id)
                    }
                }
        )
    }

}
