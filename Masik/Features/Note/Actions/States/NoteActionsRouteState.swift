//
//  NoteActionsRouteState.swift
//  Masik
//
//  Created by Роман Ломтев on 07.07.2025.
//

enum NoteActionsRouteState: Identifiable {
    
    case none
    case idle
    case deleted
    case cancelled
    
    var id: Int {
        switch self {
        case .none: return 0
        case .idle: return 1
        case .deleted: return 2
        case .cancelled: return 3
        }
    }
    
    var isPresented: Bool {
        self == .idle
    }
}
