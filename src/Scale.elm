module Scale exposing
    ( Scale
    , chromatic
    , diminishedTriad
    , harmonicMinor
    , isSemitoneDegreeInScale
    , major
    , major6
    , major6Diminished
    , majorTriad
    , minor
    , minor6
    , minor6Diminished
    , minorPentatonic
    , minorTriad
    , scaleName
    )


type Scale
    = -- A list of semitone degrees within a scale
      Scale { name : String, degrees : List Int }


scaleName : Scale -> String
scaleName (Scale s) =
    s.name


isSemitoneDegreeInScale : Scale -> Int -> Bool
isSemitoneDegreeInScale (Scale s) degree =
    List.member degree s.degrees


chromatic : Scale
chromatic =
    Scale { name = "Chromatic", degrees = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ] }


major : Scale
major =
    Scale { name = "Major", degrees = [ 0, 2, 4, 5, 7, 9, 11 ] }


minor : Scale
minor =
    Scale { name = "Minor", degrees = [ 0, 2, 3, 5, 7, 8, 10 ] }


majorTriad : Scale
majorTriad =
    Scale { name = "Major triad", degrees = [ 0, 4, 7 ] }


minorTriad : Scale
minorTriad =
    Scale { name = "Minor triad", degrees = [ 0, 3, 7 ] }


diminishedTriad : Scale
diminishedTriad =
    Scale { name = "Diminished triad", degrees = [ 0, 3, 6 ] }


harmonicMinor : Scale
harmonicMinor =
    Scale { name = "Harmonic Minor", degrees = [ 0, 2, 3, 5, 7, 8, 11 ] }


minorPentatonic : Scale
minorPentatonic =
    Scale { name = "Minor Pentatonic", degrees = [ 0, 3, 5, 8, 10 ] }


major6 : Scale
major6 =
    Scale { name = "Major 6", degrees = [ 0, 4, 7, 9 ] }


minor6 : Scale
minor6 =
    Scale { name = "Minor 6", degrees = [ 0, 3, 7, 9 ] }


major6Diminished : Scale
major6Diminished =
    Scale { name = "Major 6 Diminished", degrees = [ 0, 2, 4, 5, 7, 8, 9, 11 ] }


minor6Diminished : Scale
minor6Diminished =
    Scale { name = "Minor", degrees = [ 0, 2, 3, 5, 7, 8, 9, 11 ] }
