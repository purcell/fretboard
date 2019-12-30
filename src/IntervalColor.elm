module IntervalColor exposing (DegreeColorFn, contrasting, rainbow)

import Array exposing (Array)
import Color exposing (Color)


type alias DegreeColorFn =
    Int -> Color


rainbow : DegreeColorFn
rainbow i =
    Color.hsl (toFloat i / 12) 1 0.5


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
