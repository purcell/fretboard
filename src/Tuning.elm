module Tuning exposing (Tuning, standardSeven, standardSix, ukulele)

import Scale exposing (Modifier(..), Note(..), NoteLetter(..), Tone, toTone)


type alias Tuning =
    -- String pitches from uppermost string to string nearest ground
    List Tone


standardSix : Tuning
standardSix =
    List.map toTone
        [ Note E Natural 3
        , Note A Natural 3
        , Note D Natural 4
        , Note G Natural 4
        , Note B Natural 4
        , Note E Natural 5
        ]


standardSeven : Tuning
standardSeven =
    toTone (Note B Natural 2) :: standardSix


ukulele : Tuning
ukulele =
    List.map toTone
        [ Note G Natural 4
        , Note C Natural 4
        , Note E Natural 4
        , Note A Natural 4
        ]
