import UIKit
import AVFoundation

class SoundPlayer: NSObject, AVAudioPlayerDelegate {
    private var musics = [
        ["californy", "カリフォルニー"],
        ["rhythmOfTheSun", "RHYTHM OF THE SUN"],
        ["tonbo", "とんぼ"],
        ["hiGKLow", "hi G K low"],
        ["dayByDay", "Day by day"],
        ["koe", "声"],
        ["midori", "ミドリ"],
        ["parents", "ペアレンツ"],
        ["beFree", "BE FREE"],
        ["holiday", "Holiday!"],
        ["am1100", "AM11:00"],
        ["366Nichi", "366日"]
    ]
    private var indexOfPlayingMusic = 0
    private var musicData: Data!
    var musicPlayer: AVAudioPlayer!
    var musicName: String!
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    override init() {
        super.init()

        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            musicData = NSDataAsset(name: musics.first!.first!)!.data
            musicPlayer = try AVAudioPlayer(data: musicData)
            musicName = musics[indexOfPlayingMusic].last
        } catch {
            print("Initialize Error")
        }
    }

    func setMusic() {
        do {
            musicData = NSDataAsset(name: musics[indexOfPlayingMusic].first!)!.data
            musicPlayer = try AVAudioPlayer(data: musicData)
            musicName = musics[indexOfPlayingMusic].last
            musicPlayer.delegate = self
        } catch {
            print("Load Error")
        }
    }

    func playMusic() {
        musicPlayer.play()
    }

    func pauseMusic() {
        musicPlayer.pause()
    }

    func stopMusic() {
        musicPlayer.stop()
        musicPlayer.currentTime = 0
    }

    func backwardMusic() {
        musicPlayer.currentTime -= 5
    }

    func forwardMusic() {
        musicPlayer.currentTime += 5
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

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        indexOfPlayingMusic = (indexOfPlayingMusic + 1) % musics.count
        setMusic()
        playMusic()
    }

    func startTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }

    func stopTimer() {
        timer.upstream.connect().cancel()
    }
    
    func shuffle(fileName: String) {
        let index = musics.firstIndex(where: { $0.first == fileName })
        let firstItem = musics.remove(at: index!)
        musics.shuffle()
        musics.insert(firstItem, at: 0)
        indexOfPlayingMusic = 0
        setMusic()
    }
}
