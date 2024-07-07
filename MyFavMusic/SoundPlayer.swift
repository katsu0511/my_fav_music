import UIKit
import AVFoundation

class SoundPlayer: NSObject, AVAudioPlayerDelegate {
    var musicName: String = ""
    var musicData: Data!
    var musicPlayer: AVAudioPlayer!
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    override init() {
        super.init()

        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            musicData = NSDataAsset(name: "californy")!.data
            musicPlayer = try AVAudioPlayer(data: musicData)
        } catch {
            print("Initialize Error")
        }
    }

    func setMusic(name: String) {
        self.musicName = name
        do {
            musicData = NSDataAsset(name: musicName)!.data
            musicPlayer = try AVAudioPlayer(data: musicData)
        } catch {
            print("Load Error")
        }
    }

    func playMusic() {
        musicPlayer.play()
    }

    func pauseMusic() {
        musicPlayer?.pause()
    }

    func stopMusic() {
        musicPlayer?.stop()
        musicPlayer?.currentTime = 0
    }

    func backwardMusic() {
        musicPlayer?.currentTime -= 5
    }

    func forwardMusic() {
        musicPlayer?.currentTime += 5
    }

    func getMinute(sec: Int) -> String {
        var minute = 0
        var second = sec
        var secondStr = ""
        while(second >= 60) {
            minute += 1
            second -= 60
        }
        if (second < 10) {
            secondStr = "0\(second)"
        } else {
            secondStr = "\(second)"
        }

        return "\(minute):\(secondStr)"
    }

    func startTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }

    func stopTimer() {
        timer.upstream.connect().cancel()
    }
}
