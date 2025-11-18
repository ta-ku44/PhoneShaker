import SwiftUI
import AVFoundation

class SoundManager: NSObject {
    static let shared = SoundManager()
    private var audioPlayers: [AVAudioPlayer] = []
    
    private override init() {
        super.init()
        setupAudioSession()
    }
    
    private func setupAudioSession() {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, options: [.mixWithOthers])
            try session.setActive(true)
        } catch {
            print("AudioSession 設定エラー: \(error)")
        }
    }
    
    func playSound(named name: String, filetype: String = "mp3") {
        guard let url = Bundle.main.url(forResource: name, withExtension: filetype) else {
            print("サウンドファイルが見つかりません: \(name).\(filetype)")
            return
        }
        
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            player.play()
            
            audioPlayers.append(player)
        } catch {
            print("サウンド再生エラー: \(error)")
        }
    }
}

extension SoundManager: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if let index = audioPlayers.firstIndex(of: player) {
            audioPlayers.remove(at: index)
        }
    }
}
