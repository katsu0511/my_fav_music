//
//  PlayView.swift
//  MyFavMusic
//
//  Created by Katsuya Harada on 2024/10/06.
//

import SwiftUI
import MediaPlayer

struct PlayView: View {
    @AppStorage("isShuffle") private var isShuffle = false
    @AppStorage("shuffleButton") private var shuffleButton = "no_shuffle"
    @AppStorage("kindOfRepeat") private var kindOfRepeat = "no_repeat"
    @State private var isPlayDisabled = false
    @State private var playButton = "pause"
    @State private var isBackDisabled = false
    @State private var backButton = "back"
    @State private var isNextDisabled = false
    @State private var nextButton = "next"
    @State private var isRewindDisabled = false
    @State private var rewindButton = "rewind"
    @State private var isForwardDisabled = false
    @State private var forwardButton = "forward"
    @State private var seekPosition: Double = 0.0
    @State private var thumbnail: String! = ""
    @State private var title: String! = ""
    @State private var artist: String! = ""
    @State private var isShowingList: Bool = false
    private var player: SoundPlayer!

    init(player: SoundPlayer, musicInfo: [String]) {
        self.player = player
        thumbnail = musicInfo[1]
        title = musicInfo.last
        artist = musicInfo[2]
        preparePlay(file: musicInfo.first!)
        UISlider.appearance().thumbTintColor = .systemBlue
        skipRemoteCommand()
    }

    var body: some View {
        VStack {
            Spacer().frame(height: 48)

            HStack {
                Spacer().frame(width: 24)

                Image(thumbnail)
                    .resizable()
                    .frame(width: .infinity)
                    .aspectRatio(1, contentMode: .fit)
                    .cornerRadius(10)
                    .onReceive(player.timer) { _ in
                        thumbnail = player.thumbnail!
                    }

                Spacer().frame(width: 24)
            }

            Spacer().frame(height: 36)

            HStack {
                Spacer().frame(width: 16)

                VStack {
                    Text(title)
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fontWeight(.medium)
                        .onReceive(player.timer) { _ in
                            title = player.musicName!
                        }

                    Text(artist)
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.gray)
                        .onReceive(player.timer) { _ in
                            artist = player.artist!
                        }
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
                        setSeekPosition()
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

            Spacer()

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
                Spacer().frame(width: 24)

                Button(action: {
                    pushRewindButton()
                }) {
                    Image(rewindButton)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                }
                .disabled(isRewindDisabled)

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
                    pushNextButton()
                }) {
                    Image(nextButton)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }
                .disabled(isNextDisabled)

                Spacer()

                Button(action: {
                    pushForwardButton()
                }) {
                    Image(forwardButton)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                }
                .disabled(isForwardDisabled)

                Spacer().frame(width: 24)
            }

            Spacer()

            HStack {
                Spacer()

                Button(action: {
                    isShowingList.toggle()
                }) {
                    Image("list")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                }
                .sheet(isPresented: $isShowingList) {
                    ListView(player: player)
                }

                Spacer().frame(width: 16)
            }

            Spacer().frame(height: 16)
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
        isBackDisabled = false
        backButton = "back"
        isNextDisabled = false
        nextButton = "next"
        isRewindDisabled = false
        rewindButton = "rewind"
        isForwardDisabled = false
        forwardButton = "forward"
    }

    func pushPlayButton() {
        player.playMusic()
        player.startTimer()
        playButton = "pause"
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

    func pushRewindButton() {
        if (player.musicPlayer.currentTime < 5) {
            player.musicPlayer.currentTime = 0
            seekPosition = 0
        } else {
            player.musicPlayer.currentTime -= 5
            setSeekPosition()
        }
    }

    func pushForwardButton() {
        if (player.musicPlayer.duration - player.musicPlayer.currentTime < 5) {
            player.musicPlayer.currentTime = player.musicPlayer.duration
        } else {
            player.musicPlayer.currentTime += 5
            setSeekPosition()
        }
    }

    func setSeekPosition() {
        seekPosition = player.musicPlayer.currentTime / player.musicPlayer.duration
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
            player.musicPlayer.currentTime = Double(positionCommandEvent.positionTime)
            setSeekPosition()
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

        commandCenter.skipBackwardCommand.removeTarget(self)
        commandCenter.skipBackwardCommand.isEnabled = false
        commandCenter.skipBackwardCommand.preferredIntervals = [NSNumber(integerLiteral: 5)]
        commandCenter.skipBackwardCommand.addTarget { [self] event in
            pushRewindButton()
            return .success
        }

        commandCenter.skipForwardCommand.removeTarget(self)
        commandCenter.skipForwardCommand.isEnabled = false
        commandCenter.skipForwardCommand.preferredIntervals = [NSNumber(integerLiteral: 5)]
        commandCenter.skipForwardCommand.addTarget { [self] event in
            pushForwardButton()
            return .success
        }
    }

    func setNowPlayingInfo() {
        let center = MPNowPlayingInfoCenter.default()
        var nowPlayingInfo = center.nowPlayingInfo ?? [String : Any]()

        nowPlayingInfo[MPMediaItemPropertyTitle] = player.musicName
        nowPlayingInfo[MPMediaItemPropertyArtist] = player.artist
        nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: CGSize(width: 50, height: 50)) { _ in
            return UIImage(named: player.thumbnail)!
        }

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
