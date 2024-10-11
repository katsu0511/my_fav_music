class MusicData {
    let musics: [[String]] = [
        ["californy", "californy_thumbnail", "ケツメイシ", "カリフォルニー"],
        ["rhythmOfTheSun", "rhythmOfTheSun_thumbnail", "ケツメイシ", "RHYTHM OF THE SUN"],
        ["tonbo", "tonbo_thumbnail", "長渕剛", "とんぼ"],
        ["hiGKLow", "hiGKLow_thumbnail", "GReeeeN", "hi G K low"],
        ["dayByDay", "ahDomo_thumbnail", "GReeeeN", "Day by day"],
        ["koe", "koe_thumbnail", "GReeeeN", "声"],
        ["midori", "ahDomo_thumbnail", "GReeeeN", "ミドリ"],
        ["parents", "parents_thumbnail", "GReeeeN", "ペアレンツ"],
        ["beFree", "beFree_thumbnail", "GReeeeN", "BE FREE"],
        ["holiday", "en_thumbnail", "GReeeeN", "Holiday!"],
        ["moonTrap", "en_thumbnail", "GReeeeN", "ムーントラップ"],
        ["nabinobi", "en_thumbnail", "GReeeeN", "ナビノビ！"],
        ["stillll", "en_thumbnail", "GReeeeN", "stillll"],
        ["am1100", "am1100_thumbnail", "HY", "AM11:00"],
        ["366Nichi", "366Nichi_thumbnail", "HY", "366日"],
        ["konomichinosakide", "onesLifeTime_thumbnail", "PLAYEST", "この道の先で"],
        ["sakurasakukoro", "onesLifeTime_thumbnail", "PLAYEST", "桜咲く頃"],
        ["saigonoippo", "onesLifeTime_thumbnail", "PLAYEST", "最後の一歩"]
    ]

    var showingList: [Bool] = []

    init() {
        for _ in 0..<musics.count {
            showingList.append(false)
        }
    }
}
