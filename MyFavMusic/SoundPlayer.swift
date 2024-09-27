import UIKit
import AVFoundation

class SoundPlayer: NSObject, AVAudioPlayerDelegate {
    private var musics: [[String]] = [
        ["californy", "californy.jpg", "カリフォルニー"],
        ["rhythmOfTheSun", "rhythmOfTheSun.jpg", "RHYTHM OF THE SUN"],
        ["tonbo", "tonbo.jpg", "とんぼ"],
        ["hiGKLow", "hiGKLow.jpg", "hi G K low"],
        ["dayByDay", "dayByDay.jpg", "Day by day"],
        ["koe", "koe.jpg", "声"],
        ["midori", "ahDomo.jpg", "ミドリ"],
        ["parents", "parents.jpg", "ペアレンツ"],
        ["beFree", "beFree.jpg", "BE FREE"],
        ["holiday", "en.jpg", "Holiday!"],
        ["moonTrap", "en.jpg", "ムーントラップ"],
        ["nabinobi", "en.jpg", "ナビノビ！"],
        ["stillll", "en.jpg", "stillll"],
        ["am1100", "am1100.jpg", "AM11:00"],
        ["366Nichi", "366Nichi.jpg", "366日"],
        ["konomichinosakide", "onesLifeTime.jpg", "この道の先で"],
        ["sakurasakukoro", "onesLifeTime.jpg", "桜咲く頃"],
        ["saigonoippo", "onesLifeTime.jpg", "最後の一歩"]
    ]
    private var indexOfPlayingMusic: Int = 0
    private var kindOfRepeat: String = "no_repeat"
    private var musicData: Data!
    var musicPlayer: AVAudioPlayer!
    var musicName: String?
    var thumbnail: String!
    var playList: [[String]]!
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    override init() {
        super.init()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didAudioSessionRouteChange(_:)),
            name: AVAudioSession.routeChangeNotification,
            object: nil
        )

        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            musicData = NSDataAsset(name: musics.first!.first!)!.data
            musicPlayer = try AVAudioPlayer(data: musicData)
            thumbnail = musics.first![1]
            playList = musics
        } catch {
            print("Initialize Error")
        }
    }

    @objc private func didAudioSessionRouteChange(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let routeChangeReasonRawValue = userInfo[AVAudioSessionRouteChangeReasonKey] as? UInt,
            let routeChangeReason = AVAudioSession.RouteChangeReason(rawValue: routeChangeReasonRawValue)
        else {
            return
        }

        switch routeChangeReason {
            case .newDeviceAvailable:
                playMusic()
                startTimer()
            case .oldDeviceUnavailable:
                pauseMusic()
                stopTimer()
            default:
                break
        }
    }

    @objc private func didAudioSessionInterruption(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let interruptionTypeRawValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
            let interruptionType = AVAudioSession.InterruptionType(rawValue: interruptionTypeRawValue)
        else {
            return
        }

        switch interruptionType {
        case .began:
            pauseMusic()
            stopTimer()
        case .ended:
            var shouldResume = false
            if let interruptionOptionRawValue = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt {
                let interruptionOptions = AVAudioSession.InterruptionOptions(rawValue: interruptionOptionRawValue)
                shouldResume = interruptionOptions.contains(.shouldResume)
            }
            if shouldResume {
                playMusic()
                startTimer()
            }
        @unknown default:
            fatalError()
        }
    }

    func setMusic() {
        do {
            musicData = NSDataAsset(name: playList[indexOfPlayingMusic].first!)!.data
            musicPlayer = try AVAudioPlayer(data: musicData)
            musicName = playList[indexOfPlayingMusic].last
            thumbnail = playList[indexOfPlayingMusic][1]
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

    func shuffleOrder(fileName: String, isSongSelected: Bool = false) {
        playList = musics
        let index = playList.firstIndex(where: { $0.first == fileName })
        let firstItem = playList.remove(at: index!)
        playList.shuffle()
        playList.insert(firstItem, at: 0)
        indexOfPlayingMusic = 0
        if (isSongSelected) {
            setMusic()
        }
    }

    func originalOrder(fileName: String, isSongSelected: Bool = false) {
        playList = musics
        let index = playList.firstIndex(where: { $0.first == fileName })
        indexOfPlayingMusic = index!
        if (isSongSelected) {
            setMusic()
        }
    }

    func arrangeList(fileName: String, isShuffle: Bool, kindOfRepeat: String) {
        self.kindOfRepeat = kindOfRepeat
        if (isShuffle) {
            shuffleOrder(fileName: fileName, isSongSelected: true)
        } else {
            originalOrder(fileName: fileName, isSongSelected: true)
        }
    }
}
