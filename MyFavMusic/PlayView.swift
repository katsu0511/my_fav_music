//
//  PlayView.swift
//  MyFavMusic
//
//  Created by Katsuya Harada on 2024/10/06.
//

import SwiftUI
import MediaPlayer

struct PlayView: View {
    @AppStorage("shuffleButton") private var shuffleButton = "no_shuffle"
    @AppStorage("kindOfRepeat") private var kindOfRepeat = "no_repeat"
    @State private var playButton = "pause"
    @State private var seekPosition: Double = 0.0
    @State private var thumbnail: String! = ""
    @State private var title: String! = ""
    @State private var artist: String! = ""
    @State private var isShowingList: Bool = false
    private let player: SoundPlayer!

    init(player: SoundPlayer, musicInfo: [String]) {
        self.player = player
        thumbnail = musicInfo[1]
        title = musicInfo.last
        artist = musicInfo[2]
        preparePlay(file: musicInfo.first!)
        UISlider.appearance().thumbTintColor = .gray
        skipRemoteCommand()
    }

    var body: some View {
        VStack {
            Spacer().frame(height: 48)

            HStack {
                Spacer().frame(width: 24)

                Image(thumbnail)
                    .resizable()
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
                        .foregroundStyle(.black)
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
                .tint(.gray)
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
                    .foregroundStyle(.black)

                Spacer()

                Text("-" + player.getMinute(sec: Int(round(player.musicPlayer.duration * (1 - seekPosition)))))
                    .foregroundStyle(.black)

                Spacer().frame(width: 16)
            }

            Spacer()

            HStack {
                Spacer()

                Button(action: {
                    let fileName = player.getCurrentFileName()
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
                    Image("rewind")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                }

                Spacer()

                Button(action: {
                    pushBackButton()
                }) {
                    Image("back")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }

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

                Spacer().frame(width: 24)

                Button(action: {
                    pushNextButton()
                }) {
                    Image("next")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }

                Spacer()

                Button(action: {
                    pushForwardButton()
                }) {
                    Image("forward")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                }

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
                    ListView(player: player, playView: self)
                }

                Spacer().frame(width: 16)
            }

            Spacer().frame(height: 16)
        }
        .background(.white)
    }

    func preparePlay(file: String) {
        seekPosition = 0
        player.arrangeList(fileName: file, shuffle: shuffleButton, kindOfRepeat: kindOfRepeat)
        title = player.musicName!
        player.playMusic()
        player.startTimer()
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
        if (kindOfRepeat == "repeat_1song" && player.musicPlayer.currentTime < 1) {
            kindOfRepeat = "repeat"
        }
        let action = player.backMusic(kindOfRepeat: self.kindOfRepeat)
        if (action == "play") {
            pushPlayButton()
        }
        seekPosition = 0
    }

    func pushNextButton() {
        if (kindOfRepeat == "repeat_1song") {
            kindOfRepeat = "repeat"
        }
        let action = player.nextMusic(kindOfRepeat: self.kindOfRepeat)
        if (action == "play") {
            pushPlayButton()
        } else {
            pushPauseButton()
        }
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
