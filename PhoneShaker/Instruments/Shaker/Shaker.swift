import AVFoundation
import Foundation

class Shaker: Instrument{
    private var audioPlayer: AVAudioPlayer?
    
    public let filetype: String = "mp3"
    
    func processInput(accel: SIMD3<Double>, time: TimeInterval){
        let power = accel.sum()
        print("振動パワー: \(power)")
        if power > 1.25 {
            SoundManager.shared.playSound(named: "Shaker01-1(Single)")
        } else if power > 1 {
            SoundManager.shared.playSound(named: "Shaker01-2(Single)")
        }
    }
}
