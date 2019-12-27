module Fretboard exposing (Fretboard, default, view)

import Color exposing (Color)
import Html exposing (Html)
import TypedSvg exposing (circle, line, rect, svg)
import TypedSvg.Attributes exposing (cx, cy, fill, height, r, stroke, strokeWidth, viewBox, width, x, x1, x2, y, y1, y2)
import TypedSvg.Core exposing (Svg)
import TypedSvg.Types exposing (Fill(..), Length(..), px)


type alias Fretboard =
    { numStrings : Int
    , numFrets : Int
    , labels : List Label
    }


type alias Position =
    { string : Int
    , fret : Int
    }


type alias Label =
    -- Later: convert to sum type of "note name", "interval number" etc.
    { position : Position
    , color : Color
    }


default : Fretboard
default =
    { numStrings = 6
    , numFrets = 15
    , labels =
        [ { position = { string = 1, fret = 0 }, color = Color.rgba 255 0 0 80 }
        , { position = { string = 2, fret = 3 }, color = Color.rgba 0 255 0 80 }
        ]
    }


view : Fretboard -> Html msg
view model =
    let
        fretColumnWidthPx =
            40

        nutWidthPx =
            fretColumnWidthPx / 4

        stringSlicePx =
            20

        fretWidthPx =
            3

        fingerboard =
            rect
                [ fill (Fill (Color.rgb255 240 240 240))
                , width (Percent 100)
                , height (Percent 100)
                , stroke (Color.rgb255 180 180 180)
                , strokeWidth (px 1)
                ]
                []

        nut =
            rect
                [ x (px (fretColumnWidthPx - nutWidthPx))
                , width (px nutWidthPx)
                , height (Percent 100)
                , fill (Fill (Color.rgb255 180 180 180))
                , stroke (Color.rgb255 180 180 180)
                , strokeWidth (px 1)
                ]
                []

        fretboardHeightPx =
            toFloat (model.numStrings * stringSlicePx)

        stringYPx i =
            fretboardHeightPx - (toFloat i - 0.5) * stringSlicePx

        strings =
            List.map string (List.range 1 model.numStrings)

        string : Int -> Svg msg
        string i =
            line
                [ x1 (Percent 0)
                , y1 (px (stringYPx i))
                , y2 (px (stringYPx i))
                , x2 (Percent 100)
                , stroke Color.black
                , strokeWidth (px (1 + logBase 10 (toFloat (1 + model.numStrings - i))))
                ]
                []

        frets =
            List.map fret (List.range 1 model.numFrets)

        fretOffsetPx i =
            toFloat i * fretColumnWidthPx

        -- (12 / toFloat model.numFrets) * 200 * (1 - (1 / (2 ^ (toFloat i / 12))))
        fret i =
            rect
                [ x (px (fretOffsetPx i))
                , height (Percent 100)
                , width (px fretWidthPx)
                , fill (Fill Color.white)
                , stroke (Color.rgb255 180 180 180)
                , strokeWidth (px 1)
                ]
                []

        inlays =
            List.concatMap inlay (List.range 1 model.numFrets)

        fretFingerOffsetPx i =
            (0.5 + toFloat i) * fretColumnWidthPx + fretWidthPx / 2

        inlay i =
            let
                ni =
                    modBy 12 i

                dotCx =
                    fretFingerOffsetPx i

                dotAtY y =
                    circle
                        [ cy (Percent y)
                        , cx (px dotCx)
                        , r (px (stringSlicePx * 0.2))
                        , fill (Fill (Color.rgb255 90 90 90))
                        ]
                        []
            in
            if ni == 0 then
                [ dotAtY 17, dotAtY 83 ]

            else if ni == 3 || ni == 5 || ni == 7 || ni == 9 then
                [ dotAtY 50
                ]

            else
                []

        labels =
            List.map label model.labels

        labelRadiusPx =
            (stringSlicePx / 2) * 0.8

        label l =
            circle
                [ cx (px (fretFingerOffsetPx l.position.fret))
                , cy (px (stringYPx l.position.string))
                , r (px labelRadiusPx)
                , fill (Fill l.color)
                ]
                []

        fretboardLengthPx =
            toFloat ((model.numFrets + 1) * fretColumnWidthPx) + fretWidthPx

        marginPx =
            20
    in
    svg [ width (Percent 100), viewBox 0 0 (fretboardLengthPx + 2 * marginPx) (fretboardHeightPx + 2 * marginPx) ]
        [ svg [ x (px marginPx), y (px marginPx), height (px fretboardHeightPx), width (px fretboardLengthPx), viewBox 0 0 fretboardLengthPx fretboardHeightPx ]
            ([ nut
             , svg [ x (px fretColumnWidthPx) ]
                (fingerboard :: (frets ++ inlays ++ strings))
             ]
                ++ labels
            )
        ]
