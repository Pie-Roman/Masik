//
//  NoteListTabsViewModel.swift
//  Masik
//
//  Created by Roman Lomtev on 03.08.2025.
//

import SwiftUI

final class NoteListTabsViewModel: ObservableObject {

    @Published var tags: [NoteTag] = []
}
