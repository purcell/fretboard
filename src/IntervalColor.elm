module IntervalColor exposing
    ( DegreeColorFn
    , colorblind
    , colorfulDistinct
    , contrasting
    , rainbow
    )

import Array exposing (Array)
import Color exposing (Color)


type alias DegreeColorFn =
    Int -> Color


rainbow : DegreeColorFn
rainbow i =
    Color.hsl (toFloat i / 12) 1 0.5


colorblind : DegreeColorFn
colorblind =
    -- https://medialab.github.io/iwanthue/
    schemedSemitoneDegreeColor <|
        Array.fromList
            [ Color.rgb255 183 73 65
            , Color.rgb255 196 112 53
            , Color.rgb255 149 134 58
            , Color.rgb255 192 173 63
            , Color.rgb255 74 130 53
            , Color.rgb255 122 195 102
            , Color.rgb255 69 188 141
            , Color.rgb255 32 216 253
            , Color.rgb255 109 124 214
            , Color.rgb255 94 53 133
            , Color.rgb255 196 108 189
            , Color.rgb255 185 73 115
            ]


colorfulDistinct : DegreeColorFn
colorfulDistinct =
    -- http://vrl.cs.brown.edu/color
    schemedSemitoneDegreeColor <|
        Array.fromList
            [ Color.rgb255 254 0 0 -- Red
            , Color.rgb255 81 191 133 -- Blue green
            , Color.rgb255 123 68 25 -- Brown
            , Color.rgb255 76 72 155 -- Dark blue
            , Color.rgb255 75 227 46 -- Bright green
            , Color.rgb255 127 32 172 -- Purple
            , Color.rgb255 206 19 101 -- Dark Pink
            , Color.rgb255 242 169 102 -- Orange
            , Color.rgb255 161 222 240 -- Light blue
            , Color.rgb255 186 227 66 -- Pale green
            , Color.rgb255 17 93 82 -- Dark green
            , Color.rgb255 250 175 227 -- Pink
            ]


contrasting : DegreeColorFn
contrasting =
    schemedSemitoneDegreeColor colorbrewerDivergent


colorbrewerDivergent : Array Color
colorbrewerDivergent =
    Array.fromList
        [ Color.rgb255 227 26 28 -- Red
        , Color.rgb255 202 178 214 -- Light purple
        , Color.rgb255 253 191 111 -- Light brown
        , Color.rgb255 31 120 180 -- Blue
        , Color.rgb255 51 160 44 -- Green
        , Color.rgb255 251 154 153 -- Pink
        , Color.rgb255 106 61 154 -- Purple
        , Color.rgb255 255 127 0 -- Orange
        , Color.rgb255 177 89 40 -- Brown
        , Color.rgb255 178 223 138 -- Light green
        , Color.rgb255 166 206 227 -- Light blue
        , Color.rgb255 255 255 153 -- Yellow
        ]


schemedSemitoneDegreeColor : Array Color.Color -> Int -> Color.Color
schemedSemitoneDegreeColor scheme i =
    Maybe.withDefault Color.lightGrey (Array.get i scheme)
