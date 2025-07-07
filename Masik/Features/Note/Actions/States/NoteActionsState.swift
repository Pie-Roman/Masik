//
//  NoteActionsState.swift
//  Masik
//
//  Created by Роман Ломтев on 07.07.2025.
//

import Foundation

enum NoteActionsState {
    
    case idle
    case deleted
    case cancelled
    
    var id: Int {
        switch self {
        case .idle: return 0
        case .deleted: return 1
        case .cancelled: return 2
        }
    }
}
