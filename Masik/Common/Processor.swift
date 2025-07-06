//
//  Processor.swift
//  Masik
//
//  Created by Роман Ломтев on 06.07.2025.
//

protocol Processor {
    
    associatedtype Intent
    
    func process(intent: Intent)
}
