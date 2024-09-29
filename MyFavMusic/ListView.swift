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
                if (item.last == player.musicName) {
                    Button(action: {
                    }) {
                        Text(item.last!)
                    }
                    .listRowBackground(Color.blue)
                    .foregroundColor(Color.white)
                } else {
                    Button(action: {
                    }) {
                        Text(item.last!)
                    }
                }
            }
        }
    }
}
