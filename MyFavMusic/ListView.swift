//
//  ListView.swift
//  MyFavMusic
//
//  Created by Katsuya Harada on 2024/09/14.
//

import SwiftUI

struct ListView: View {
    @Environment(\.dismiss) private var dismiss
    private let player: SoundPlayer!
    private let currentIndex: Int!
    private let playView: PlayView

    init(player: SoundPlayer, playView: PlayView) {
        self.player = player
        self.playView = playView
        currentIndex = player.playList.firstIndex(where: { $0.last == player.musicName }) ?? 0
    }

    var body: some View {
        VStack {
            Spacer().frame(height: 16)

            HStack {
                Spacer().frame(width: 16)

                Button(action: {
                    dismiss()
                }) {
                    Image("close")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }

                Spacer()
            }

            List(player.playList!, id: \.self) { item in
                let itemIndex: Int = player.playList.firstIndex(of: item)!
                if (currentIndex <= itemIndex) {
                    Button(action: {
                        player.skipMusic(index: itemIndex)
                        playView.pushPlayButton()
                    }) {
                        HStack {
                            if (currentIndex == itemIndex) {
                                Image(item[1])
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            }

                            VStack {
                                Text(item.last!)
                                    .font(.body)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(item.last == player.musicName ? .white : .black)

                                Text(item[2])
                                    .font(.subheadline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(item.last == player.musicName ? .white : .gray)
                            }
                        }
                    }
                    .listRowBackground(item.last == player.musicName ? Color.blue : Color.white)
                }
            }
            .listStyle(.grouped)
            .scrollContentBackground(.hidden)
        }
    }
}
