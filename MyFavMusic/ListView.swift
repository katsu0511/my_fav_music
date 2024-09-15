//
//  ListView.swift
//  MyFavMusic
//
//  Created by Katsuya Harada on 2024/09/14.
//

import SwiftUI

struct ListView: View {
    @Environment(\.dismiss) private var dismiss
    let playList = SoundPlayer().getPlayList()

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

            List(playList, id: \.self) { item in
                Button(action: {
                }) {
                    Text(item.last!)
                }
            }
        }
    }
}

#Preview {
    ListView()
}
