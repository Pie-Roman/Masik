//
//  NoteTagEntryProcessor.swift
//  Masik
//
//  Created by Роман Ломтев on 01.08.2025.
//

final class NoteTagEntryProcessor: Processor {
    
    typealias Intent = NoteTagEntryIntent
    
    weak var handler: (any NoteTagEntryHandler)?
    
    private let interactor: NoteTagEntryInteractor

    init(interactor: NoteTagEntryInteractor) {
        self.interactor = interactor
    }
    
    func process(intent: NoteTagEntryIntent) {
        switch intent {
            
        case .add(let tag):
            Task {
                do {
                    let addedTag = try await interactor.addTag(tag: tag)
                    handler?.handle(intent: .showAdded(tag: addedTag))
                } catch {
                }
            }

        case .update(let id, let tag):
            Task {
                do {
                    let updatedTag = try await interactor.updateTag(id: id, tag: tag)
                    handler?.handle(intent: .showUpdated(tag: updatedTag))
                } catch {
                }
            }

        default:
            handler?.handle(intent: intent)
        }
    }
}

