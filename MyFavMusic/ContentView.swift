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
    @State private var isShowingPlayView: Bool = false
    let player = SoundPlayer()

    var body: some View {
        VStack {

            Spacer().frame(height: 16)

            Text("My Favorite Music")
                .font(.largeTitle)

            VStack {
                List {
                    ForEach(player.musics, id: \.self) { music in
                        Button(action: {
                            isShowingPlayView.toggle()
                        }) {
                            HStack() {
                                Image(music[1])
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                Text(music.last!)
                            }
                        }
                        .sheet(isPresented: $isShowingPlayView) {
                            PlayView(player: player, musicInfo: music)
                        }
                    }
                }
                .listStyle(.grouped)
                .scrollContentBackground(.hidden)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
