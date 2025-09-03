//
//  CgColorExtensions.swift
//  Masik
//
//  Created by Роман Ломтев on 03.09.2025.
//

import UIKit

extension CGColor {
    
    func toHex() -> String {
        guard let components = self.components else { return "#000000" }
        let r = Int((components[0]) * 255)
        let g = Int((components[1]) * 255)
        let b = Int((components[2]) * 255)
        return String(format: "#%02X%02X%02X", r, g, b)
    }
}
