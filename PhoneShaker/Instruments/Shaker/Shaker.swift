import AVFoundation
import Foundation
import Combine

class Shaker: Instrument, ObservableObject {
    private var audioPlayer: AVAudioPlayer?
    
    public let filetype: String = "mp3"
    
    private var curPeak: Double = 0.0
    
    private var lastTriggerTime: TimeInterval = 0
    private let cooldown: TimeInterval = 0.235
    
    @Published public var activateAt: Double = 1.75 // 振動の強さがこの値を超えたら反応開始
    @Published public var impactDrop: Double = 0.8 // ピークからどれくらい落ちたかで反応するか
    
    func processInput(accel: SIMD3<Double>){
        let curTime = Date().timeIntervalSince1970
        // 振動の強さを計算
        let power = sqrt(accel.x * accel.x + accel.y * accel.y + accel.z * accel.z)
        if power > curPeak {
            curPeak = power
            
            return
        }
        let dropAmount = curPeak - power
        
        if curPeak > activateAt && dropAmount > impactDrop {
            if curTime - lastTriggerTime > cooldown {
                triggerSound(peakPower: curPeak)
                
                lastTriggerTime = curTime
                curPeak = 0.0
            }
        }
        
        // 勢いが弱まっているなら
        if power < 1.5 {
            curPeak = 0.0
        }
    }
    
    private func triggerSound(peakPower: Double) {
        if peakPower > 5.0 {
            SoundManager.shared.playSound(named: "Shaker01-1(Single)")
        } else {
            SoundManager.shared.playSound(named: "Shaker01-2(Single)")
        }
    }
}
