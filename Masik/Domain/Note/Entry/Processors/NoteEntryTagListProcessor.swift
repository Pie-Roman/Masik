//
//  NoteEntryTagListProcessor.swift
//  Masik
//
//  Created by Роман Ломтев on 02.08.2025.
//


final class NoteEntryTagListProcessor: Processor {
    
    typealias Intent = NoteEntryTagListIntent
    
    weak var handler: (any NoteEntryTagListHandler)?
    
    private let interactor: NoteEntryTagListInteractor

    init(interactor: NoteEntryTagListInteractor) {
        self.interactor = interactor
    }
    
    func process(intent: NoteEntryTagListIntent) {
        switch intent {
            
        case .load:
            handler?.handle(intent: .showLoading)
            Task {
                do {
                    let tagList = try await interactor.loadTagList()
                    handler?.handle(intent: .showLoaded(tagList))
                } catch {
                }
            }
            
        default:
            handler?.handle(intent: intent)
        }
    }
}
