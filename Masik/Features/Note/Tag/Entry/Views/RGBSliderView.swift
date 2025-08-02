//
//  RGBSliderView.swift
//  Masik
//
//  Created by Роман Ломтев on 02.08.2025.
//

import SwiftUI

struct RGBSliderView: View {
    var label: String
    @Binding var value: Double
    var tint: Color

    var body: some View {
        HStack {
            Text(label)
                .frame(width: 20)
                .foregroundColor(tint)

            Slider(value: $value, in: 0...255)
                .tint(tint)

            Text("\(Int(value))")
                .frame(width: 35, alignment: .trailing)
                .monospacedDigit()
        }
        .font(.subheadline)
    }
}

