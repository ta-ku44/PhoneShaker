import AVFoundation
import Foundation
import Combine

class Shaker: Instrument, ObservableObject {
    private var audioPlayer: AVAudioPlayer?
    
    public let filetype: String = "mp3"
    @Published public var push: Double = 3.0
    @Published public var pull: Double = 1.5
    
    func processInput(accel: SIMD3<Double>, time: TimeInterval){
        let power = sqrt(accel.x * accel.x + accel.y * accel.y + accel.z * accel.z)
        print("振動: \(power)")
        if power > push {
            SoundManager.shared.playSound(named: "Shaker01-1(Single)")
        } else if power > pull {
            SoundManager.shared.playSound(named: "Shaker01-2(Single)")
        }
    }
}
