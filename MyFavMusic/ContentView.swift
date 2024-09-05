//
//  ContentView.swift
//  MyFavMusic
//
//  Created by Katsuya Harada on 2024/07/07.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var isShuffle = false
    @State private var shuffleButton = "no_shuffle"
    @State private var kindOfRepeat = "no_repeat"
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
    let player = SoundPlayer()

    init() {
        UISlider.appearance().thumbTintColor = .systemBlue
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
                    if (shuffleButton == "shuffle") {
                        isShuffle = false
                        shuffleButton = "no_shuffle"
                        if (fileName != nil) {
                            player.originalOrder(fileName: fileName!)
                        }
                    } else {
                        isShuffle = true
                        shuffleButton = "shuffle"
                        if (fileName != nil) {
                            player.shuffleOrder(fileName: fileName!)
                        }
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
                    player.backMusic()
                    seekPosition = 0
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
                        player.playMusic()
                        player.startTimer()
                        playButton = "pause"
                        isStopDisabled = false
                        stopButton = "stop"
                        isBackDisabled = false
                        backButton = "back"
                        isNextDisabled = false
                        nextButton = "next"
                    } else if (playButton == "pause") {
                        player.pauseMusic()
                        player.stopTimer()
                        playButton = "play"
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
                    player.nextMusic()
                    seekPosition = 0
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
                        self.preparePlay(file: "am1100")
                    }) {
                        Text("AM11:00")
                    }

                    Button(action: {
                        self.preparePlay(file: "366Nichi")
                    }) {
                        Text("366日")
                    }

                }
            }
        }
    }

    func preparePlay(file: String) {
        player.arrangeList(fileName: file, isShuffle: isShuffle, kindOfRepeat: kindOfRepeat)
        isPlayDisabled = false
        playButton = "play"
        title = player.musicName!
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
