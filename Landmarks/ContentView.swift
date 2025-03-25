import SwiftUI

struct ContentView: View {
    @State private var emotion = "😐 감정: 대기 중..."

    var body: some View {
        ZStack {
            FaceTrackingView(emotion: $emotion)
            VStack {
                Spacer()
                Text(emotion)
                    .font(.largeTitle)
                    .bold()
                    .padding()
                    .background(.white.opacity(0.7))
                    .cornerRadius(12)
                    .padding(.bottom, 40)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}
