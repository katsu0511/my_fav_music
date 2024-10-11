//
//  ListView.swift
//  MyFavMusic
//
//  Created by Katsuya Harada on 2024/09/14.
//

import SwiftUI

struct ListView: View {
    @Environment(\.dismiss) private var dismiss
    private var player: SoundPlayer!

    init(player: SoundPlayer) {
        self.player = player
    }

    var body: some View {
        VStack {
            Spacer().frame(height: 16)

            HStack {
                Spacer().frame(width: 24)

                Button(action: {
                    dismiss()
                }) {
                    Image("close")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                }

                Spacer()
            }

            List(player.playList!, id: \.self) { item in
                let currentIndex: Int = player.playList.firstIndex(where: { $0.last == player.musicName }) ?? 0
                let itemIndex: Int = player.playList.firstIndex(of: item)!
                if (currentIndex <= itemIndex) {
                    Button(action: {
                    }) {
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
                    .listRowBackground(item.last == player.musicName ? Color.blue : Color.white)
                }
            }
            .listStyle(.grouped)
            .scrollContentBackground(.hidden)
        }
    }
}
