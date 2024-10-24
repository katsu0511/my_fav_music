class MusicData {
    let musics: [[String]] = [
        ["am1100", "am1100_thumbnail", "HY", "AM11:00"],
        ["366Nichi", "366Nichi_thumbnail", "HY", "366日"],
        ["californy", "californy_thumbnail", "ケツメイシ", "カリフォルニー"],
        ["rhythmOfTheSun", "rhythmOfTheSun_thumbnail", "ケツメイシ", "RHYTHM OF THE SUN"],
        ["sakura", "sakura_thumbnail", "ケツメイシ", "さくら"],
        ["train", "train_thumbnail", "ケツメイシ", "トレイン"],
        ["tonbo", "tonbo_thumbnail", "長渕剛", "とんぼ"],
        ["konomichinosakide", "onesLifeTime_thumbnail", "PLAYEST", "この道の先で"],
        ["sakurasakukoro", "onesLifeTime_thumbnail", "PLAYEST", "桜咲く頃"],
        ["saigonoippo", "onesLifeTime_thumbnail", "PLAYEST", "最後の一歩"],
        ["holiday", "en_thumbnail", "GReeeeN", "Holiday!"],
        ["moonTrap", "en_thumbnail", "GReeeeN", "ムーントラップ"],
        ["nabinobi", "en_thumbnail", "GReeeeN", "ナビノビ！"],
        ["stillll", "en_thumbnail", "GReeeeN", "stillll"],
        ["beFree", "beFree_thumbnail", "GReeeeN", "BE FREE"],
        ["parents", "parents_thumbnail", "GReeeeN", "ペアレンツ"],
        ["koe", "koe_thumbnail", "GReeeeN", "声"],
        ["hiGKLow", "hiGKLow_thumbnail", "GReeeeN", "hi G K low"],
        ["dayByDay", "ahDomo_thumbnail", "GReeeeN", "Day by day"],
        ["midori", "ahDomo_thumbnail", "GReeeeN", "ミドリ"],
        ["aiuta", "ahDomo_thumbnail", "GReeeeN", "愛唄"],
        ["kiseki", "kiseki_thumbnail", "GReeeeN", "キセキ"],
        ["whereverYouAre", "whereverYouAre_thumbnail", "ONE OK ROCK", "Wherever you are"],
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
        ["pretender", "pretender_thumbnail", "Official髭男dism", "Pretender"],
        ["hakujitsu", "hakujitsu_thumbnail", "King Gnu", "白日"],
        ["boy", "boy_thumbnail", "King Gnu", "BOY"],
        ["marigold", "marigold_thumbnail", "あいみょん", "マリーゴールド"],
        ["drinksForYou", "globalWarming_thumbnail", "Pitbull feat. J. Lo", "Drinks for You (Ladies Anthem)"],
        ["hotelRoomService", "globalWarming_thumbnail", "Pitbull", "Hotel Room Service"]
    ]

    var showingList: [Bool] = []

    init() {
        for _ in 0..<musics.count {
            showingList.append(false)
        }
    }
}
