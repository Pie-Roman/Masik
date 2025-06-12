//
//  OrderTaxiScreen.swift
//  Masik
//
//  Created by Роман Ломтев on 09.06.2025.
//

import SwiftUI

struct OrderTaxiScreen: View {
    @State private var fromAddress = ""
    @State private var toAddress = ""
    @State private var savedAddresses = ["Дом", "Работа", "Кафе на Арбате"]

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("🚖 Заказ такси")
                .font(.title2)
                .bold()
                .padding(.top)

            Text("Недавние адреса")
                .font(.headline)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(savedAddresses, id: \.self) { address in
                        Text(address)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color(.systemGray5))
                            .cornerRadius(10)
                    }
                }
            }

            TextField("Откуда", text: $fromAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            TextField("Куда", text: $toAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: {
                openTelegramBot(from: fromAddress, to: toAddress)
            }) {
                HStack {
                    Image(systemName: "paperplane.fill")
                    Text("Отправить в Telegram")
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
            }

            Spacer()
        }
        .padding()
    }

    func openTelegramBot(from: String, to: String) {
        let text = "Такси от: \(from)%0Aдо: \(to)"
        let urlString = "https://t.me/share/url?url=&text=\(text)"
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
}


#Preview {
    OrderTaxiScreen()
}
