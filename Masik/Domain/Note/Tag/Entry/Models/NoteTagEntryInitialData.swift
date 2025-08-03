//
//  NoteTagEntryInitialData.swift
//  Masik
//
//  Created by Roman Lomtev on 03.08.2025.
//

import Foundation

struct NoteTagEntryInitialData: Identifiable {
    let mode: NoteTagEntryMode
    let tag: NoteTag?

    var id: String {
        let tagId = tag?.id ?? "nil"
        return "\(mode)-\(tagId)"
    }
}
