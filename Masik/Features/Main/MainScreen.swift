import SwiftUI

struct MainScreen: View {
    
    @State private var showTaxiScreen = false
    
    var body: some View {
        VStack(spacing: 24) {
            
            // Заголовок
            Text("Воспоминания")
                .font(.system(size: 28, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            // Лента воспоминаний (заглушка)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(0..<5) { index in
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .frame(width: 200, height: 300)
                            .shadow(radius: 3)
                            .overlay(
                                Text("Фото \(index + 1)")
                                    .foregroundColor(.gray)
                            )
                    }
                }.padding(.horizontal)
            }
            
            // Боковое меню хотелок
            VStack(alignment: .leading, spacing: 16) {
                Text("Хотелки")
                    .font(.headline)
                    .padding(.horizontal)
                
                VStack(spacing: 12) {
                    NavigationLink(destination: OrderTaxiScreen(), isActive: $showTaxiScreen) {
                        Button(action: {
                            showTaxiScreen = true
                        }) {
                            HStack {
                                Image(systemName: "car.fill")
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .background(Color.pink)
                                    .clipShape(Circle())
                                
                                Text("Закажи такси!")
                                    .foregroundColor(.primary)
                                    .font(.body)
                                
                                Spacer()
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(radius: 2)
                        }
                    }
                    // Добавить больше хотелок здесь...
                }
                .padding(.horizontal)
            }
            
            Spacer()
        }
    }
}


