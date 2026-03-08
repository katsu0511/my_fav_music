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
    @State private var thumbnail: String = ""
    @State private var artist: String = ""
    @State private var title: String = ""
    @State private var isShowingList: Bool = false
    @State private var isExpanded: Bool = false
    
    private let player: SoundPlayer!
    private let file: String

    init(player: SoundPlayer, musicInfo: [String]) {
        self.player = player
        self.file = musicInfo.first!
        thumbnail = musicInfo[1]
        artist = musicInfo[2]
        title = musicInfo.last!
    }

    var body: some View {
        
        VStack {
            
            if isExpanded {
                
                HStack {

                    Button(action: {
                        isExpanded = false
                    }) {
                        Image("close")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .padding(.leading, 24)
                    }

                    Spacer()
                    
                }
                .padding(.vertical, 16)
                
                HStack {
                    
                    if !thumbnail.isEmpty {
                        Image(thumbnail)
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .cornerRadius(10)
                            .padding(.horizontal, 24)
                    }
                    
                }
                .padding(.bottom, 36)
                
                HStack {
                    
                    VStack {
                        
                        Text(title)
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.black)
                            .fontWeight(.medium)
                        
                        Text(artist)
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.gray)
                    }
                    .padding(.leading, 16)
                    
                    Spacer()
                }
                
                HStack {
                    
                    Slider(
                        value: $seekPosition,
                        in: 0...1,
                        onEditingChanged: { _ in
                            player.musicPlayer.currentTime = seekPosition * player.musicPlayer.duration
                        }
                    )
                    .padding(.horizontal, 16)
                    
                }
                
                HStack {
                    
                    Text(player.getMinute(sec: Int(round(player.musicPlayer.duration * seekPosition))))
                        .foregroundStyle(.black)
                        .padding(.leading, 16)
                    
                    Spacer()
                    
                    Text("-" + player.getMinute(sec: Int(round(player.musicPlayer.duration * (1 - seekPosition)))))
                        .foregroundStyle(.black)
                        .padding(.trailing, 16)
                    
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
                .padding(.bottom, 16)
                
                HStack {
                    
                    Button(action: {
                        pushRewindButton()
                    }) {
                        Image("rewind")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 35)
                    }
                    .padding(.leading, 24)
                    
                    Spacer()
                    
                    Button(action: {
                        pushBackButton()
                    }) {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                    }
                    .padding(.trailing, 24)
                    
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
                    .padding(.trailing, 24)
                    
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
                    .padding(.trailing, 24)
                    
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
                    .padding(.trailing, 16)
                    
                }
                .padding(.bottom, 16)
                
            } else {
                
                Spacer()
                
                HStack {
                    
                    VStack {
                        if !thumbnail.isEmpty {
                            Image(thumbnail)
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal, 16)
                    
                    VStack {
                        
                        Text(title)
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.black)
                            .fontWeight(.medium)
                        
                        Text(artist)
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(.gray)
                    }
                    
                    Spacer()
                    
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
                            .frame(width: 30, height: 30)
                    }
                    .padding(.trailing, 24)
                    
                }
                
                Spacer()
            }
        }
        .background(Color(red: 0.85, green: 0.85, blue: 1))
        .shadow(color: .black.opacity(isExpanded ? 0 : 0.15), radius: 8, y: -4)
        .frame(maxHeight: isExpanded ? .infinity : 60)
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.height > 120 {
                        withAnimation(.spring(duration: 0.1)) {
                            isExpanded = false
                        }
                    }
                }
        )
        .onTapGesture {
            withAnimation(.spring(duration: 0.1)) {
                if (!isExpanded) {
                    isExpanded = true
                }
            }
        }
        .onReceive(player.timer) { _ in
            if (player.musicPlayer.isPlaying) {
                setSeekPosition()
            } else {
                player.stopTimer()
            }
            setNowPlayingInfo()
            
            thumbnail = player.thumbnail!
            title = player.musicName!
            artist = player.artist!
        }
        .onAppear() {
            playRemoteCommand()
            preparePlay(file: file)
            UISlider.appearance().thumbTintColor = .systemBlue
            skipRemoteCommand()
        }
        .onChange(of: file) {
            preparePlay(file: file)
        }
    }

    func preparePlay(file: String) {
        seekPosition = 0
        player.arrangeList(fileName: file, shuffle: shuffleButton, kindOfRepeat: kindOfRepeat)
        thumbnail = player.thumbnail!
        title = player.musicName!
        artist = player.artist!
        pushPlayButton()
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
