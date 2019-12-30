module Scale exposing
    ( Scale
    , chromatic
    , harmonicMinor
    , isSemitoneDegreeInScale
    , major
    , majorTriad
    , minor
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


harmonicMinor : Scale
harmonicMinor =
    Scale { name = "Harmonic Minor", degrees = [ 0, 2, 3, 5, 7, 8, 11 ] }


minorPentatonic : Scale
minorPentatonic =
    Scale { name = "Minor Pentatonic", degrees = [ 0, 3, 5, 8, 10 ] }
