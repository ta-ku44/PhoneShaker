import SwiftUI
import AVFoundation

class SoundManager {
    static let shared = SoundManager()
    private var audioPlayer: AVAudioPlayer?

    //private init() {}

    func playSound(named name: String, filetype: String = "mp3") {
        if let path = Bundle.main.path(forResource: name, ofType: filetype) {
            let url = URL(fileURLWithPath: path)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("再生エラー: \(error)")
            }
        }
    }
}
