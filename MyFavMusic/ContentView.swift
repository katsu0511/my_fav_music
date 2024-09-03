//
//  ContentView.swift
//  MyFavMusic
//
//  Created by Katsuya Harada on 2024/07/07.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var shuffleButton = "no_shuffle"
    @State private var repeatButton = "no_repeat"
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
                    if (shuffleButton == "shuffle") {
                        shuffleButton = "no_shuffle"
                    } else {
                        shuffleButton = "shuffle"
                    }
                }) {
                    Image(shuffleButton)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                }

                Spacer()

                Button(action: {
                    if (repeatButton == "no_repeat") {
                        repeatButton = "repeat"
                    } else if (repeatButton == "repeat") {
                        repeatButton = "repeat_1song"
                    } else {
                        repeatButton = "no_repeat"
                    }
                }) {
                    Image(repeatButton)
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
                    if (!isBackDisabled) {
                        player.backMusic()
                        seekPosition = 0
                    }
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
                    if (!isStopDisabled) {
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
                    }
                }) {
                    Image(stopButton)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }
                .disabled(isStopDisabled)

                Spacer().frame(width: 24)

                Button(action: {
                    if (!isNextDisabled) {
                        player.nextMusic()
                        seekPosition = 0
                    }
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
                        player.shuffle(fileName: "californy")
                        isPlayDisabled = false
                        playButton = "play"
                        title = player.musicName!
                    }) {
                        Text("カリフォルニー")
                    }

                    Button(action: {
                        player.shuffle(fileName: "rhythmOfTheSun")
                        isPlayDisabled = false
                        playButton = "play"
                        title = player.musicName!
                    }) {
                        Text("RHYTHM OF THE SUN")
                    }

                    Button(action: {
                        player.shuffle(fileName: "tonbo")
                        isPlayDisabled = false
                        playButton = "play"
                        title = player.musicName!
                    }) {
                        Text("とんぼ")
                    }

                    Button(action: {
                        player.shuffle(fileName: "hiGKLow")
                        isPlayDisabled = false
                        playButton = "play"
                        title = player.musicName!
                    }) {
                        Text("hi G K low")
                    }

                    Button(action: {
                        player.shuffle(fileName: "dayByDay")
                        isPlayDisabled = false
                        playButton = "play"
                        title = player.musicName!
                    }) {
                        Text("Day by day")
                    }

                    Button(action: {
                        player.shuffle(fileName: "koe")
                        isPlayDisabled = false
                        playButton = "play"
                        title = player.musicName!
                    }) {
                        Text("声")
                    }

                    Button(action: {
                        player.shuffle(fileName: "midori")
                        isPlayDisabled = false
                        playButton = "play"
                        title = player.musicName!
                    }) {
                        Text("ミドリ")
                    }

                    Button(action: {
                        player.shuffle(fileName: "parents")
                        isPlayDisabled = false
                        playButton = "play"
                        title = player.musicName!
                    }) {
                        Text("ペアレンツ")
                    }

                    Button(action: {
                        player.shuffle(fileName: "beFree")
                        isPlayDisabled = false
                        playButton = "play"
                        title = player.musicName!
                    }) {
                        Text("BE FREE")
                    }

                    Button(action: {
                        player.shuffle(fileName: "holiday")
                        isPlayDisabled = false
                        playButton = "play"
                        title = player.musicName!
                    }) {
                        Text("Holiday!")
                    }

                    Button(action: {
                        player.shuffle(fileName: "am1100")
                        isPlayDisabled = false
                        playButton = "play"
                        title = player.musicName!
                    }) {
                        Text("AM11:00")
                    }

                    Button(action: {
                        player.shuffle(fileName: "366Nichi")
                        isPlayDisabled = false
                        playButton = "play"
                        title = player.musicName!
                    }) {
                        Text("366日")
                    }

                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
