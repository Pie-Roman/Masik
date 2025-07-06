//
//  Handler.swift
//  Masik
//
//  Created by Роман Ломтев on 06.07.2025.
//

protocol Handler: AnyObject {
    
    associatedtype Intent
    
    func handle(intent: Intent)
}
