//
//  ContentView.swift
//  MyFavMusic
//
//  Created by Katsuya Harada on 2024/07/07.
//

import SwiftUI
import SwiftData
import MediaPlayer

struct ContentView: View {
    @AppStorage("isShuffle") private var isShuffle = false
    @AppStorage("shuffleButton") private var shuffleButton = "no_shuffle"
    @AppStorage("kindOfRepeat") private var kindOfRepeat = "no_repeat"
    @State private var isPlayDisabled = true
    @State private var playButton = "invalid_play"
    @State private var isStopDisabled = true
    @State private var stopButton = "invalid_stop"
    @State private var isBackDisabled = true
    @State private var backButton = "invalid_back"
    @State private var isNextDisabled = true
    @State private var nextButton = "invalid_next"
    @State private var seekPosition: Double = 0.0
    @State private var title: String = "My Favorite Music"
    @State private var isShowingList: Bool = false
    let player = SoundPlayer()

    init() {
        UISlider.appearance().thumbTintColor = .systemBlue
        skipRemoteCommand()
    }

    var body: some View {
        VStack {
            Spacer().frame(height: 16)
            Text(title)
                .font(.largeTitle)
                .onReceive(player.timer) { _ in
                    if (player.musicPlayer.isPlaying) {
                        title = player.musicName!
                    }
                }

            HStack {
                Spacer().frame(width: 16)
                Slider(
                    value: $seekPosition,
                    in: 0...1,
                    onEditingChanged: { _ in
                        player.musicPlayer.currentTime = seekPosition * player.musicPlayer.duration
                    }
                )
                .onReceive(player.timer) { _ in
                    if (player.musicPlayer.isPlaying) {
                        seekPosition = player.musicPlayer.currentTime / player.musicPlayer.duration
                    } else {
                        player.stopTimer()
                    }
                    playRemoteCommand()
                    setNowPlayingInfo()
                }
                Spacer().frame(width: 16)
            }

            HStack {
                Spacer().frame(width: 16)
                Text(player.getMinute(sec: Int(round(player.musicPlayer.duration * seekPosition))))
                Spacer()
                Text("-" + player.getMinute(sec: Int(round(player.musicPlayer.duration * (1 - seekPosition)))))
                Spacer().frame(width: 16)
            }

            HStack {
                Spacer()

                Button(action: {
                    let fileName = player.getCurrentFileName()
                    isShuffle = shuffleButton == "shuffle" ? false : true
                    shuffleButton = shuffleButton == "shuffle" ? "no_shuffle" : "shuffle"
                    if (fileName != nil && shuffleButton == "shuffle") {
                        player.shuffleOrder(fileName: fileName!)
                    } else if (fileName != nil && shuffleButton == "no_shuffle") {
                        player.originalOrder(fileName: fileName!)
                    }
                }) {
                    Image(shuffleButton)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                }

                Spacer()

                Button(action: {
                    switch kindOfRepeat {
                        case "no_repeat":
                            kindOfRepeat = "repeat"
                        case "repeat":
                            kindOfRepeat = "repeat_1song"
                        case "repeat_1song":
                            kindOfRepeat = "no_repeat"
                        default:
                            break
                    }
                    player.setKindOfRepeat(kindOfRepeat: kindOfRepeat)
                }) {
                    Image(kindOfRepeat)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                }

                Spacer()
            }

            Spacer().frame(height: 16)

            HStack {
                Spacer()

                Button(action: {
                    pushBackButton()
                }) {
                    Image(backButton)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }
                .disabled(isBackDisabled)

                Spacer().frame(width: 24)

                Button(action: {
                    if (playButton == "play") {
                        pushPlayButton()
                    } else if (playButton == "pause") {
                        pushPauseButton()
                    }
                }) {
                    Image(playButton)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }
                .disabled(isPlayDisabled)

                Spacer().frame(width: 24)

                Button(action: {
                    player.stopMusic()
                    seekPosition = 0.0
                    player.stopTimer()
                    playButton = "play"
                    isStopDisabled = true
                    stopButton = "invalid_stop"
                    isBackDisabled = true
                    backButton = "invalid_back"
                    isNextDisabled = true
                    nextButton = "invalid_next"
                }) {
                    Image(stopButton)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }
                .disabled(isStopDisabled)

                Spacer().frame(width: 24)

                Button(action: {
                    pushNextButton()
                }) {
                    Image(nextButton)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }
                .disabled(isNextDisabled)

                Spacer()
            }

            Spacer().frame(height: 16)

            HStack {
                Spacer()

                Button(action: {
                    isShowingList.toggle()
                }) {
                    Image("list")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                }
                .sheet(isPresented: $isShowingList) {
                    ListView(playList: player.playList)
                }

                Spacer().frame(width: 24)
            }

            VStack {
                List {

                    Button(action: {
                        self.preparePlay(file: "californy")
                    }) {
                        Text("カリフォルニー")
                    }

                    Button(action: {
                        self.preparePlay(file: "rhythmOfTheSun")
                    }) {
                        Text("RHYTHM OF THE SUN")
                    }

                    Button(action: {
                        self.preparePlay(file: "tonbo")
                    }) {
                        Text("とんぼ")
                    }

                    Button(action: {
                        self.preparePlay(file: "hiGKLow")
                    }) {
                        Text("hi G K low")
                    }

                    Button(action: {
                        self.preparePlay(file: "dayByDay")
                    }) {
                        Text("Day by day")
                    }

                    Button(action: {
                        self.preparePlay(file: "koe")
                    }) {
                        Text("声")
                    }

                    Button(action: {
                        self.preparePlay(file: "midori")
                    }) {
                        Text("ミドリ")
                    }

                    Button(action: {
                        self.preparePlay(file: "parents")
                    }) {
                        Text("ペアレンツ")
                    }

                    Button(action: {
                        self.preparePlay(file: "beFree")
                    }) {
                        Text("BE FREE")
                    }

                    Button(action: {
                        self.preparePlay(file: "holiday")
                    }) {
                        Text("Holiday!")
                    }

                    Button(action: {
                        self.preparePlay(file: "moonTrap")
                    }) {
                        Text("ムーントラップ")
                    }

                    Button(action: {
                        self.preparePlay(file: "nabinobi")
                    }) {
                        Text("ナビノビ！")
                    }

                    Button(action: {
                        self.preparePlay(file: "stillll")
                    }) {
                        Text("stillll")
                    }

                    Button(action: {
                        self.preparePlay(file: "am1100")
                    }) {
                        Text("AM11:00")
                    }

                    Button(action: {
                        self.preparePlay(file: "366Nichi")
                    }) {
                        Text("366日")
                    }

                    Button(action: {
                        self.preparePlay(file: "konomichinosakide")
                    }) {
                        Text("この道の先で")
                    }

                    Button(action: {
                        self.preparePlay(file: "sakurasakukoro")
                    }) {
                        Text("桜咲く頃")
                    }

                    Button(action: {
                        self.preparePlay(file: "saigonoippo")
                    }) {
                        Text("最後の一歩")
                    }

                }
            }
        }
    }

    func preparePlay(file: String) {
        seekPosition = 0
        player.arrangeList(fileName: file, isShuffle: isShuffle, kindOfRepeat: kindOfRepeat)
        isPlayDisabled = false
        playButton = "pause"
        title = player.musicName!
        player.playMusic()
        player.startTimer()
        isStopDisabled = false
        stopButton = "stop"
        isBackDisabled = false
        backButton = "back"
        isNextDisabled = false
        nextButton = "next"
    }

    func pushPlayButton() {
        player.playMusic()
        player.startTimer()
        playButton = "pause"
        isStopDisabled = false
        stopButton = "stop"
        isBackDisabled = false
        backButton = "back"
        isNextDisabled = false
        nextButton = "next"
    }

    func pushPauseButton() {
        player.pauseMusic()
        player.stopTimer()
        playButton = "play"
    }

    func pushBackButton() {
        player.backMusic()
        seekPosition = 0
    }

    func pushNextButton() {
        player.nextMusic()
        seekPosition = 0
    }

    func playRemoteCommand() {
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.removeTarget(self)
        commandCenter.playCommand.isEnabled = true
        commandCenter.playCommand.addTarget { [self] event in
            pushPlayButton()
            return .success
        }

        commandCenter.pauseCommand.removeTarget(self)
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.pauseCommand.addTarget { [self] event in
            pushPauseButton()
            return .success
        }

        commandCenter.changePlaybackPositionCommand.removeTarget(self)
        commandCenter.changePlaybackPositionCommand.isEnabled = true
        commandCenter.changePlaybackPositionCommand.addTarget { [self] event in
            guard let positionCommandEvent = event as? MPChangePlaybackPositionCommandEvent else { return .commandFailed }
            seekPosition = Double(positionCommandEvent.positionTime) / player.musicPlayer.duration
            return .success
        }
    }

    func skipRemoteCommand() {
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.previousTrackCommand.removeTarget(self)
        commandCenter.previousTrackCommand.isEnabled = true
        commandCenter.previousTrackCommand.addTarget { [self] event in
            pushBackButton()
            return .success
        }

        commandCenter.nextTrackCommand.removeTarget(self)
        commandCenter.nextTrackCommand.isEnabled = true
        commandCenter.nextTrackCommand.addTarget { [self] event in
            pushNextButton()
            return .success
        }
    }

    func setNowPlayingInfo() {
        let center = MPNowPlayingInfoCenter.default()
        var nowPlayingInfo = center.nowPlayingInfo ?? [String : Any]()

        nowPlayingInfo[MPMediaItemPropertyTitle] = player.musicName

//        let size = CGSize(width: 50, height: 50)
//        if let image = currentItem?.artwork?.image(at: size) {
//            nowPlayingInfo[MPMediaItemPropertyArtwork] =
//            MPMediaItemArtwork(boundsSize: image.size) { _ in
//                return image
//            }
//        } else {
//            nowPlayingInfo[MPMediaItemPropertyArtwork] = nil
//        }

        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = player.musicPlayer.currentTime

        if player.musicPlayer.isPlaying {
            nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = player.musicPlayer.rate
        } else {
            nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = 0.0
        }

        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = player.musicPlayer.duration
        center.nowPlayingInfo = nowPlayingInfo
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
