import AVFoundation
import Foundation

class Shaker: Instrument{
    private var player: AVAudioPlayer?
    
    func processInput(accel: SIMD3<Double>, time: TimeInterval){
        let power = abs(accel.x) + abs(accel.y) + abs(accel.z)
        if power > 1.2{
            // 押す際のサウンドを再生
        } else if power > 0.7{
            // 引く際のサウンドを再生
        }
    }
}
