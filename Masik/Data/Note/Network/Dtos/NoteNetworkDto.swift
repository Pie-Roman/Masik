//
//  NoteNetworkDto.swift
//  Masik
//
//  Created by Roman Lomtev on 17.06.2025.
//

import Foundation

struct NoteNetworkDto: Identifiable, Codable {
    let id: String?
    let body: NoteBodyNetworkDto?
}
