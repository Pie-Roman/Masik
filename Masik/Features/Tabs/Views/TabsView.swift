//
//  TabsScreen.swift
//  Masik
//
//  Created by Роман Ломтев on 12.06.2025.
//

import SwiftUI

import SwiftUI

struct TabsView: View {
    
    @State private var selectedTab: Tab = .main
    private let tabBarWidth: CGFloat = 200
    private let tabItemWidth: CGFloat = 60
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case .main: MainView()
                case .notes: NoteListView()
                case .wishlist: WishlistView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.self) { tab in
                    Button(action: {
                        withAnimation(.interactiveSpring(response: 0.25, dampingFraction: 0.7)) {
                            selectedTab = tab
                        }
                    }) {
                        VStack(spacing: 6) {
                            Image(systemName: tab.icon)
                                .font(.system(size: 20, weight: .medium))
                                .frame(width: 24, height: 24)
                            
                            Circle()
                                .fill(selectedTab == tab ? Color.white : Color.clear)
                                .frame(width: 4, height: 4)
                        }
                        .frame(width: tabItemWidth, height: 44)
                        .contentShape(Rectangle())
                    }
                    .foregroundColor(selectedTab == tab ? .white : Color(white: 0.75))
                }
            }
            .padding(.horizontal, 10)
            .padding(.top, 12)
            .padding(.bottom, 8)
            .background(
                RoundedRectangle(cornerRadius: 32)
                    .fill(Color.black.opacity(0.95))
                    .shadow(color: .black.opacity(0.25), radius: 12, x: 0, y: 4)
            )
            .frame(width: tabBarWidth, height: 60)
            .padding(.bottom, 48)
            .compositingGroup()
        }
        .ignoresSafeArea(.container, edges: .bottom)
    }
}

private enum Tab: Int, CaseIterable {
    case main, notes, wishlist
    
    var icon: String {
        switch self {
        case .main: return "house.fill"
        case .notes: return "list.bullet"
        case .wishlist: return "heart.fill"
        }
    }
}
