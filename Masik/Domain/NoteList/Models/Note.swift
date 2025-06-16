//
//  Note.swift
//  Masik
//
//  Created by Roman Lomtev on 17.06.2025.
//

import Foundation

struct Note: Identifiable, Codable {
    var id = UUID()
    var title: String
    var isDone: Bool = false
    var dateCreated: Date = Date()
}
