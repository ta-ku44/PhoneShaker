import Foundation

protocol Instrument {
    func processInput(accel: SIMD3<Double>, time: TimeInterval)
}
