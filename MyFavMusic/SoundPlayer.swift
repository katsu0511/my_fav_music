import UIKit
import AVFoundation

class SoundPlayer: NSObject, AVAudioPlayerDelegate {
    private var musics: [[String]] = [
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
        ["moonTrap", "ムーントラップ"],
        ["nabinobi", "ナビノビ！"],
        ["stillll", "stillll"],
        ["am1100", "AM11:00"],
        ["366Nichi", "366日"]
    ]
    private var playList: [[String]]!
    private var indexOfPlayingMusic: Int = 0
    private var kindOfRepeat: String = "no_repeat"
    private var musicData: Data!
    var musicPlayer: AVAudioPlayer!
    var musicName: String?
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    override init() {
        super.init()

        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            musicData = NSDataAsset(name: musics.first!.first!)!.data
            musicPlayer = try AVAudioPlayer(data: musicData)
            playList = musics
        } catch {
            print("Initialize Error")
        }
    }

    func setMusic() {
        do {
            musicData = NSDataAsset(name: playList[indexOfPlayingMusic].first!)!.data
            musicPlayer = try AVAudioPlayer(data: musicData)
            musicName = playList[indexOfPlayingMusic].last
            musicPlayer.delegate = self
        } catch {
            print("Load Error")
        }
    }

    func getCurrentFileName() -> String? {
        var fileName: String?
        if (musicName != nil) {
            let index = playList.firstIndex(where: { $0.last == musicName })
            fileName = playList[index!].first
        }
        return fileName
    }

    func setKindOfRepeat(kindOfRepeat: String) {
        self.kindOfRepeat = kindOfRepeat
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

    func backMusic() {
        if (
            kindOfRepeat == "no_repeat" && musicPlayer.currentTime < 1 && indexOfPlayingMusic != 0 ||
            kindOfRepeat == "repeat" && musicPlayer.currentTime < 1
        ) {
            indexOfPlayingMusic = indexOfPlayingMusic == 0 ? playList.count - 1 : indexOfPlayingMusic - 1
            setMusic()
            playMusic()
        } else {
            musicPlayer.currentTime = 0
        }
    }

    func nextMusic() {
        if (kindOfRepeat == "no_repeat" || kindOfRepeat == "repeat") {
            indexOfPlayingMusic = (indexOfPlayingMusic + 1) % playList.count
            setMusic()
        }
        musicPlayer.currentTime = 0
        if (kindOfRepeat == "no_repeat" && indexOfPlayingMusic == 0) {
            stopMusic()
        } else {
            playMusic()
        }
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
        nextMusic()
    }

    func startTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }

    func stopTimer() {
        timer.upstream.connect().cancel()
    }

    func shuffleOrder(fileName: String) {
        playList = musics
        let index = playList.firstIndex(where: { $0.first == fileName })
        let firstItem = playList.remove(at: index!)
        playList.shuffle()
        playList.insert(firstItem, at: 0)
        indexOfPlayingMusic = 0
        if (!musicPlayer.isPlaying) {
            setMusic()
        }
    }

    func originalOrder(fileName: String) {
        playList = musics
        let index = playList.firstIndex(where: { $0.first == fileName })
        indexOfPlayingMusic = index!
        if (!musicPlayer.isPlaying) {
            setMusic()
        }
    }

    func arrangeList(fileName: String, isShuffle: Bool, kindOfRepeat: String) {
        self.kindOfRepeat = kindOfRepeat
        if (isShuffle) {
            shuffleOrder(fileName: fileName)
        } else {
            originalOrder(fileName: fileName)
        }
    }
}
