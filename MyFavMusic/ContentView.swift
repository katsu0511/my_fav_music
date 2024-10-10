//
//  ContentView.swift
//  MyFavMusic
//
//  Created by Katsuya Harada on 2024/07/07.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingPlayView: [Bool] = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    let player = SoundPlayer()

    var body: some View {
        VStack {
            Spacer().frame(height: 16)

            Text("My Favorite Music")
                .font(.largeTitle)

            VStack {
                List(Array(player.musics.enumerated()), id: \.element) { (index, music) in
                    Button(action: {
                        isShowingPlayView[index].toggle()
                    }) {
                        HStack() {
                            Image(music[1])
                                .resizable()
                                .frame(width: 50, height: 50)

                            VStack {
                                Text(music.last!)
                                    .font(.body)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundStyle(.black)
                                Text(music[2])
                                    .font(.subheadline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundStyle(.gray)
                            }
                        }
                    }
                    .fullScreenCover(isPresented: $isShowingPlayView[index]) {
                        PlayView(player: player, musicInfo: music)
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
