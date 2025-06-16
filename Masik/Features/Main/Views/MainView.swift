import SwiftUI

struct MainView: View {

    @State private var showTaxiScreen = false
    
    var body: some View {
        VStack(spacing: 24) {
            
            Text("Привет, Масик! 💕")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

            Text("Вот твои воспоминания:")
                .font(.title2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

            RandomPhotoView()
            
            // Хотелки
            VStack(alignment: .leading, spacing: 16) {
                Text("Хотелки")
                    .font(.headline)
                    .padding(.horizontal)
                
                VStack(spacing: 12) {
                    NavigationLink(destination: OrderTaxiView(), isActive: $showTaxiScreen) {
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


