import SwiftUI
import CoreMotion
import Combine
import simd

class MotionManager: ObservableObject {
    private let motion = CMMotionManager()
    
    @Published var vibVec = SIMD3<Double>(0, 0, 0)
    var instrument: Instrument?
    
    func startDetecting() {
        guard motion.isAccelerometerAvailable else {
            print("加速度センサーが利用できません")
            return
        }
        
        motion.accelerometerUpdateInterval = 0.05
        motion.startAccelerometerUpdates(to: .main) { [weak self] data, _ in
            guard let acc = data?.acceleration else { return }
            
            self?.vibVec = SIMD3(acc.x, acc.y, acc.z)
            self?.instrument?.processInput(accel: self!.vibVec, time: data!.timestamp)
        }
    }
    
    func stopDetecting() {
        motion.stopAccelerometerUpdates()
    }
}
