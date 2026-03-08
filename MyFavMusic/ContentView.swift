//
//  ContentView.swift
//  MyFavMusic
//
//  Created by Katsuya Harada on 2024/07/07.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedMusic: [String]? = nil
    
    let player = SoundPlayer()

    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            VStack {
                
                Spacer().frame(height: 16)
                
                Text("My Favorite Music")
                    .font(.largeTitle)
                    .foregroundStyle(.black)
                
                List(Array(player.musics.enumerated()), id: \.offset) { (index, music) in
                    
                    Button {
                        selectedMusic = music
                    } label: {
                        
                        HStack() {
                            
                            Image(music[1])
                                .resizable()
                                .frame(width: 50, height: 50)
                            
                            VStack(alignment: .leading) {
                                
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
                    .listRowBackground(Color.white)
                }
                .listStyle(.grouped)
                .scrollContentBackground(.hidden)
                .padding(.bottom, 40)
            }
            
            if let music = selectedMusic {
                PlayView(
                    player: player,
                    musicInfo: music
                )
            }
        }
        .background(.white)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
