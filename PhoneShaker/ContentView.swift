import SwiftUI

struct ContentView: View {
    @StateObject private var motionManager = MotionManager()
    private let shaker = Shaker()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("加速度")
                .font(.largeTitle)
                .bold()
            
            HStack {
                Text("X:")
                    .frame(width: 30, alignment: .leading)
                Text(String(format: "%.3f", motionManager.vibVec.x))
                    .font(.system(.body, design: .monospaced))
            }
            
            HStack {
                Text("Y:")
                    .frame(width: 30, alignment: .leading)
                Text(String(format: "%.3f", motionManager.vibVec.y))
                    .font(.system(.body, design: .monospaced))
            }
            
            HStack {
                Text("Z:")
                    .frame(width: 30, alignment: .leading)
                Text(String(format: "%.3f", motionManager.vibVec.z))
                    .font(.system(.body, design: .monospaced))
            }
            
            Button("Stop") {
                motionManager.stopDetecting()
            }
            Button("Start") {
                motionManager.startDetecting()
            }
        }
        .padding()
        .onAppear {
            motionManager.instrument = shaker
            motionManager.startDetecting()
        }
        .onDisappear {
            motionManager.stopDetecting()
        }
    }
}
