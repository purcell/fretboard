module Note exposing
    ( Modifier(..)
    , Note(..)
    , NoteLetter(..)
    , Tone
    , addSemitones
    , noteToString
    , semitoneDegree
    , toNote
    , toTone
    )


type
    Tone
    -- Opaque internal representation of a tone
    = Tone Int


intervalSize : Tone -> Tone -> Int
intervalSize (Tone from) (Tone to) =
    to - from


semitoneDegree : Tone -> Tone -> Int
semitoneDegree tonic other =
    modBy 12 (intervalSize tonic other)


addSemitones : Tone -> Int -> Tone
addSemitones (Tone i) s =
    Tone (i + s)


type NoteLetter
    = C
    | D
    | E
    | F
    | G
    | A
    | B


noteLetterToString : NoteLetter -> String
noteLetterToString n =
    case n of
        A ->
            "A"

        B ->
            "B"

        C ->
            "C"

        D ->
            "D"

        E ->
            "E"

        F ->
            "F"

        G ->
            "G"


semitonesAboveC : NoteLetter -> Int
semitonesAboveC name =
    case name of
        C ->
            0

        D ->
            2

        E ->
            4

        F ->
            5

        G ->
            7

        A ->
            9

        B ->
            11


type Modifier
    = Flat
    | Natural
    | Sharp


modifierToString : Modifier -> String
modifierToString mod =
    case mod of
        Flat ->
            "♭"

        Sharp ->
            "♯"

        Natural ->
            ""


type Note
    = Note NoteLetter Modifier Int


toTone : Note -> Tone
toTone (Note name modifier octave) =
    Tone
        (12
            * octave
            + semitonesAboveC name
            + (case modifier of
                Flat ->
                    -1

                Natural ->
                    0

                Sharp ->
                    1
              )
        )


toNote : Tone -> Note
toNote (Tone i) =
    let
        octave =
            i // 12

        ( name, modifier ) =
            case modBy 12 i of
                0 ->
                    ( C, Natural )

                1 ->
                    ( C, Sharp )

                2 ->
                    ( D, Natural )

                3 ->
                    ( D, Sharp )

                4 ->
                    ( E, Natural )

                5 ->
                    ( F, Natural )

                6 ->
                    ( F, Sharp )

                7 ->
                    ( G, Natural )

                8 ->
                    ( G, Sharp )

                9 ->
                    ( A, Natural )

                10 ->
                    ( A, Sharp )

                11 ->
                    ( B, Natural )

                -- Unfortunately necessary catch-all
                _ ->
                    ( C, Natural )
    in
    Note name modifier octave


noteToString : Note -> String
noteToString (Note name modifier _) =
    noteLetterToString name ++ modifierToString modifier
