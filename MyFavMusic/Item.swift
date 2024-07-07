//
//  Item.swift
//  MyFavMusic
//
//  Created by Katsuya Harada on 2024/07/07.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
