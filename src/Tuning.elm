module Tuning exposing (Tuning, standardSeven, standardSix)

import Scale exposing (Modifier(..), NoteName(..), Tone, toTone)


type alias Tuning =
    -- String pitches from uppermost string to string nearest ground
    List Tone


standardSix : Tuning
standardSix =
    List.map toTone
        [ { name = E, modifier = Natural, octave = 3 }
        , { name = A, modifier = Natural, octave = 3 }
        , { name = D, modifier = Natural, octave = 4 }
        , { name = G, modifier = Natural, octave = 4 }
        , { name = B, modifier = Natural, octave = 4 }
        , { name = E, modifier = Natural, octave = 5 }
        ]


standardSeven : Tuning
standardSeven =
    toTone { name = B, modifier = Natural, octave = 2 } :: standardSix
