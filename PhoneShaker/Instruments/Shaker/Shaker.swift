import AVFoundation
import Foundation

class Shaker: Instrument{
    private var audioPlayer: AVAudioPlayer?
    
    public let filetype: String = "mp3"
    
    func processInput(accel: SIMD3<Double>, time: TimeInterval){
        let power = accel.sum()
        print(power)
        if power > 10.25 {
            SoundManager.shared.playSound(named: "Shaker01-1(Single)")
        } else if power > 0.75 {
            SoundManager.shared.playSound(named: "Shaker01-1(Single)")
        }
    }
}
