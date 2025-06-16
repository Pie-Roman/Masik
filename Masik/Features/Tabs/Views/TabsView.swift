//
//  TabsScreen.swift
//  Masik
//
//  Created by Роман Ломтев on 12.06.2025.
//

import SwiftUI

struct TabsView: View {

    init() {
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().backgroundColor = UIColor.white.withAlphaComponent(0.9)
        UITabBar.appearance().unselectedItemTintColor = UIColor.systemGray
    }

    @State private var selectedTab: Tab = .main
    @GestureState private var dragOffset: CGFloat = 0

    var body: some View {
        let views: [Tab: AnyView] = [
            .main: AnyView(MainView()),
            .notelist: AnyView(NoteListView()),
            .wishlist: AnyView(WishlistView())
        ]

        NavigationView {
            ZStack {
                Color(.systemGray6).edgesIgnoringSafeArea(.all)

                VStack {
                    TabView(selection: $selectedTab) {
                        ForEach(Tab.allCases, id: \ .self) { tab in
                            views[tab]
                                .tag(tab)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .gesture(DragGesture().updating($dragOffset, body: { value, state, _ in
                        state = value.translation.width
                    }).onEnded { value in
                        if value.translation.width < -50, let nextTab = Tab.tab(at: selectedTab.index + 1) {
                            withAnimation(.easeInOut) {
                                selectedTab = nextTab
                            }
                        }
                        if value.translation.width > 50, let previousTab = Tab.tab(at: selectedTab.index - 1) {
                            withAnimation(.easeInOut) {
                                selectedTab = previousTab
                            }
                        }
                    })

                    HStack {
                        Spacer()
                        Button(action: {
                            withAnimation(.easeInOut) {
                                selectedTab = .main
                            }
                        }) {
                            VStack {
                                Image(systemName: "house.fill")
                                Text("Главная")
                            }
                            .foregroundColor(selectedTab == .main ? .pink : .gray)
                        }
                        Spacer()
                        Button(action: {
                            withAnimation(.easeInOut) {
                                selectedTab = .notelist
                            }
                        }) {
                            VStack {
                                Image(systemName: "list.bullet")
                                Text("Что сделать")
                            }
                            .foregroundColor(selectedTab == .notelist ? .pink : .gray)
                        }
                        Spacer()
                        Button(action: {
                            withAnimation(.easeInOut) {
                                selectedTab = .wishlist
                            }
                        }) {
                            VStack {
                                Image(systemName: "heart.fill")
                                Text("Вишлист")
                            }
                            .foregroundColor(selectedTab == .wishlist ? .pink : .gray)
                        }
                        Spacer()
                    }
                    .padding(.top, 6)
                    .padding(.bottom, 12)
                    .background(Color.white.opacity(0.9).ignoresSafeArea(edges: .bottom))
                }
            }
        }
    }
}

private enum Tab: CaseIterable {
    case main
    case notelist
    case wishlist

    var index: Int {
        switch self {
        case .main: return 0
        case .notelist: return 1
        case .wishlist: return 2
        }
    }

    static func tab(at index: Int) -> Tab? {
        return Self.allCases.first { $0.index == index }
    }
}
