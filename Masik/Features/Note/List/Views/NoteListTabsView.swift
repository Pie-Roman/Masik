//
//  NoteListTagTabsView.swift
//  Masik
//
//  Created by Roman Lomtev on 03.08.2025.
//

import SwiftUI

struct NoteListTabsView<Content>: View where Content : View {

    @EnvironmentObject var viewModel: NoteListTabsViewModel

    let onTabTapAction: (NoteTag?) -> Void
    let content: Content

    init(
        onTabTapAction: @escaping (NoteTag?) -> Void,
        @ViewBuilder content: () -> Content
    ) {
        self.onTabTapAction = onTabTapAction
        self.content = content()
    }

    var body: some View {
        VStack {

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top) {

                    noteListTabView(
                        name: "Все",
                        color: Color(uiColor: .systemGray5),
                        action: {
                            onTabTapAction(nil)
                        }
                    )

                    ForEach(viewModel.tags, id: \.name) { tag in
                        noteListTabView(
                            name: tag.name,
                            color: Color(hex: tag.color) ?? Color(uiColor: .systemGray5),
                            action: {
                                onTabTapAction(tag)
                            }
                        )
                    }
                }
            }
            .padding(.top, 8)


            content
        }
        .padding(.horizontal)
    }

    @ViewBuilder
    private func noteListTabView(
        name: String,
        color: Color,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text(name)
                .font(.headline)
                .foregroundColor(.black)
                .padding()
                .background(color)
                .cornerRadius(24)
        }
        .buttonStyle(.plain)
    }
}
