//
//  NoteListNetworkDto.swift
//  Masik
//
//  Created by Roman Lomtev on 17.06.2025.
//

import Foundation

struct NoteListNetworkDto: Codable {
    let items: [NoteNetworkDto]?
}
