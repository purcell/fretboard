module Fretboard exposing (..)

import Color
import Html exposing (Html)
import TypedSvg exposing (line, rect, svg)
import TypedSvg.Attributes exposing (fill, height, stroke, strokeWidth, viewBox, width, x, x1, x2, y, y1, y2)
import TypedSvg.Core exposing (Svg)
import TypedSvg.Types exposing (Fill(..), Length(..), px)


type alias Fretboard =
    {}


default : Fretboard
default =
    {}


view : Fretboard -> Html msg
view board =
    let
        fingerboard =
            rect
                [ fill (Fill (Color.rgb255 220 220 220))
                , width (Percent 100)
                , height (Percent 100)
                , stroke (Color.rgb255 180 180 180)
                , strokeWidth (px 1)
                ]
                []

        nut =
            rect
                [ width (px 10)
                , height (px 100)
                , fill (Fill (Color.rgb255 180 180 180))
                , stroke (Color.rgb255 180 180 180)
                , strokeWidth (px 1)
                ]
                []

        strings =
            List.map string (List.range 1 numStrings)

        string : Int -> Svg msg
        string i =
            let
                slicePct =
                    100 / numStrings

                stringY =
                    100 + (slicePct * (0.5 - toFloat i))
            in
            line
                [ x1 (Percent 0)
                , y1 (Percent stringY)
                , y2 (Percent stringY)
                , x2 (Percent 100)
                , stroke (Color.rgb255 140 140 140)
                , strokeWidth (px (1 + logBase 10 (toFloat (1 + numStrings - i))))
                ]
                []

        numStrings =
            6

        frets : List (Svg msg)
        frets =
            []
    in
    svg [ viewBox 0 0 600 200 ]
        [ svg [ x (px 50), y (px 50), width (px 500), height (px 100) ]
            [ fingerboard
            , nut
            , svg [ x (px 10) ]
                strings
            ]
        ]
