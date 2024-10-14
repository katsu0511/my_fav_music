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
        ["dayByDay", "ahDomo_thumbnail", "GReeeeN", "Day by day"],
        ["parents", "parents_thumbnail", "GReeeeN", "ペアレンツ"],
        ["koe", "koe_thumbnail", "GReeeeN", "声"],
        ["midori", "ahDomo_thumbnail", "GReeeeN", "ミドリ"],
        ["hiGKLow", "hiGKLow_thumbnail", "GReeeeN", "hi G K low"],
        ["whereverYouAre", "whereverYouAre_thumbnail", "ONE OK ROCK", "Wherever you are"],
        ["utautainoBallad", "utautainoBallad_thumbnail", "斉藤和義", "歌うたいのバラッド"],
        ["lemon", "lemon_thumbnail", "米津玄師", "Lemon"],
        ["eineKleine", "eineKleine_thumbnail", "米津玄師", "アイネクライネ"],
        ["orion", "bootleg_thumbnail", "米津玄師", "orion"],
        ["uchiagehanabi", "bootleg_thumbnail", "DAOKO × 米津玄師", "打上花火"]
    ]

    var showingList: [Bool] = []

    init() {
        for _ in 0..<musics.count {
            showingList.append(false)
        }
    }
}
