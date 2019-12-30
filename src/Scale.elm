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
    )


type Scale
    = -- A list of semitone degrees within a scale
      Scale (List Int)


isSemitoneDegreeInScale : Scale -> Int -> Bool
isSemitoneDegreeInScale (Scale degrees) degree =
    List.member degree degrees


chromatic : Scale
chromatic =
    Scale [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ]


major : Scale
major =
    Scale [ 0, 2, 4, 5, 7, 9, 11 ]


minor : Scale
minor =
    Scale [ 0, 2, 3, 5, 7, 8, 10 ]


majorTriad : Scale
majorTriad =
    Scale [ 0, 4, 7 ]


minorTriad : Scale
minorTriad =
    Scale [ 0, 3, 7 ]


harmonicMinor : Scale
harmonicMinor =
    Scale [ 0, 2, 3, 5, 7, 8, 11 ]


minorPentatonic : Scale
minorPentatonic =
    Scale [ 0, 3, 5, 8, 10 ]
