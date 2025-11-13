import SwiftUI
import CoreMotion
import Combine
import simd

class MotionManager: ObservableObject {
    private let motionManager = CMMotionManager()
    
    @Published var vibVec = SIMD3<Double>(x: 0, y: 0, z: 0) // 振動値
    
    func startDetecting() {
        guard motionManager.isAccelerometerAvailable else {
            print("加速度センサーが利用できません")
            return
        }
        
        motionManager.accelerometerUpdateInterval = 0.5
        motionManager.startAccelerometerUpdates(to: .main) { [weak self] data, error in
            guard let self = self, let acceleration = data?.acceleration else { return }
            
            self.vibVec.x = acceleration.x
            self.vibVec.y = acceleration.y
            self.vibVec.z = acceleration.z

            print("X: \(acceleration.x)")
            print("Y: \(acceleration.y)")
            print("Z: \(acceleration.z)")
            print("---------------------")
        }
    }
    
    func stopDetecting() {
        motionManager.stopAccelerometerUpdates()
    }
}

struct ContentView: View {
    @StateObject private var motionManager = MotionManager()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("振動値")
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
        }
        .padding()
        .onAppear {
            motionManager.startDetecting()
        }
        .onDisappear {
            motionManager.stopDetecting()
        }
    }
}

@main
struct ShakerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
