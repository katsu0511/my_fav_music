//
//  MusicData.swift
//  MyFavMusic
//
//  Created by Katsuya Harada on 2024/10/11.
//

class MusicData {
    let musics: [[String]] = [
        ["am1100", "am1100_thumbnail", "HY", "AM11:00"],
        ["366Nichi", "366Nichi_thumbnail", "HY", "366日"],
        ["californy", "californy_thumbnail", "ケツメイシ", "カリフォルニー"],
        ["rhythmOfTheSun", "rhythmOfTheSun_thumbnail", "ケツメイシ", "RHYTHM OF THE SUN"],
        ["tonbo", "tonbo_thumbnail", "長渕剛", "とんぼ"],
        ["konomichinosakide", "onesLifeTime_thumbnail", "PLAYEST", "この道の先で"],
        ["sakurasakukoro", "onesLifeTime_thumbnail", "PLAYEST", "桜咲く頃"],
        ["saigonoippo", "onesLifeTime_thumbnail", "PLAYEST", "最後の一歩"],
        ["holiday", "en_thumbnail", "GReeeeN", "Holiday!"],
        ["beFree", "beFree_thumbnail", "GReeeeN", "BE FREE"],
        ["parents", "parents_thumbnail", "GReeeeN", "ペアレンツ"],
        ["koe", "koe_thumbnail", "GReeeeN", "声"],
        ["hiGKLow", "hiGKLow_thumbnail", "GReeeeN", "hi G K low"],
        ["dayByDay", "ahDomo_thumbnail", "GReeeeN", "Day by day"],
        ["midori", "ahDomo_thumbnail", "GReeeeN", "ミドリ"],
        ["utautainoBallad", "utautainoBallad_thumbnail", "斉藤和義", "歌うたいのバラッド"],
        ["lemon", "lemon_thumbnail", "米津玄師", "Lemon"],
        ["eineKleine", "eineKleine_thumbnail", "米津玄師", "アイネクライネ"],
        ["orion", "bootleg_thumbnail", "米津玄師", "orion"],
        ["loser", "bootleg_thumbnail", "米津玄師", "LOSER"],
        ["uchiagehanabi", "bootleg_thumbnail", "DAOKO × 米津玄師", "打上花火"],
        ["walkOn", "walkOn_thumbnail", "ORANGE RANGE", "Walk on"],
        ["yumekaze", "natural_thumbnail", "ORANGE RANGE", "yumekaze"],
        ["winterWinner", "natural_thumbnail", "ORANGE RANGE", "Winter Winner"],
        ["hystericTaxi", "natural_thumbnail", "ORANGE RANGE", "HYSTERIC TAXI"],
        ["sayonara", "allTheSingles_thumbnail", "ORANGE RANGE", "SAYONARA"],
        ["michishirube", "allTheSingles_thumbnail", "ORANGE RANGE", "ミチシルベ～a road home～"],
        ["rakuyou", "allTheSingles_thumbnail", "ORANGE RANGE", "落陽"],
        ["kizuna", "allTheSingles_thumbnail", "ORANGE RANGE", "キズナ"],
        ["loveParade", "allTheSingles_thumbnail", "ORANGE RANGE", "ラヴ・パレード"],
        ["one", "one_thumbnail", "RIP SLYME", "One"],
        ["blow", "goodTimes_thumbnail", "RIP SLYME", "ブロウ"],
        ["rakuenBaby", "goodTimes_thumbnail", "RIP SLYME", "楽園ベイベー"],
        ["nettaiya", "goodTimes_thumbnail", "RIP SLYME", "熱帯夜"],
        ["goodDay", "goodTimes_thumbnail", "RIP SLYME", "Good Day"],
        ["lovey", "goodTimes_thumbnail", "リップスライムとくるり", "ラヴぃ"],
        ["funkasticBattle", "goodTimes_thumbnail", "RIP SLYME vs HOTEI", "FUNKASTIC BATTLE"],
        ["remember", "goodTimes_thumbnail", "RIP SLYME with MONGOL800", "Remember"],
        ["blingBangBangBorn", "blingBangBangBorn_thumbnail", "Creepy Nuts", "Bling-Bang-Bang-Born"],
        ["hakujitsu", "hakujitsu_thumbnail", "King Gnu", "白日"],
        ["boy", "boy_thumbnail", "King Gnu", "BOY"],
        ["drinksForYou", "globalWarming_thumbnail", "Pitbull feat. J. Lo", "Drinks for You (Ladies Anthem)"],
        ["hotelRoomService", "globalWarming_thumbnail", "Pitbull", "Hotel Room Service"],
        ["lastNight", "globalWarming_thumbnail", "Pitbull feat. Havana Brown & Afrojack", "Last Night"],
        ["dontStopTheParty", "globalWarming_thumbnail", "Pitbull feat. TJR", "Don't Stop The Party"],
        ["danceAgain", "globalWarming_thumbnail", "Jennifer Lopez feat. Pitbull", "Dance Again"],
        ["anotherDayOfSun", "laLaLand_thumbnail", "La La Land Cast", "Another Day Of Sun"],
        ["someoneInTheCrowd", "laLaLand_thumbnail", "La La Land Cast", "Someone In The Crowd"],
        ["cityOfStars", "laLaLand_thumbnail", "Ryan Gosling", "City Of Stars"],
        ["aLovelyNight", "laLaLand_thumbnail", "La La Land Cast", "A Lovely Night"],
        ["hero", "hero_thumbnail", "Family of the Year", "Hero"],
        ["yellow", "yellow_thumbnail", "Coldplay", "Yellow"],
        ["soakUpTheSun", "soakUpTheSun_thumbnail", "Sheryl Crow", "Soak Up The Sun"],
        ["gimmeGimmeGimme", "mammaMia_thumbnail", "Mamma Mia!", "Gimme! Gimme! Gimme!"],
        ["aMillionDreams", "theGreatestShowman_thumbnail", "The Greatest Showman Cast", "A Million Dreams"],
        ["thisIsMe", "theGreatestShowman_thumbnail", "The Greatest Showman Cast", "This Is Me"],
        ["theGreatestShow", "theGreatestShowman_thumbnail", "The Greatest Showman Cast", "The Greatest Show"],
        ["comeAlive", "theGreatestShowman_thumbnail", "The Greatest Showman Cast", "Come Alive"],
        ["theOtherSide", "theGreatestShowman_thumbnail", "The Greatest Showman Cast", "The Other Side"],
        ["rewriteTheStars", "theGreatestShowman_thumbnail", "The Greatest Showman Cast", "Rewrite The Stars"]
    ]

    var showingList: [Bool] = []

    init() {
        for _ in 0..<musics.count {
            showingList.append(false)
        }
    }
}
