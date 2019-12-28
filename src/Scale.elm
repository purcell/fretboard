module Scale exposing
    ( Modifier(..)
    , NamedNote
    , NoteName(..)
    , Tone
    , addSemitones
    , namedNoteToString
    , toNote
    , toTone
    )


type
    Tone
    -- Opaque internal representation of a tone
    = Tone Int


addSemitones : Tone -> Int -> Tone
addSemitones (Tone i) s =
    Tone (i + s)


type NoteName
    = C
    | D
    | E
    | F
    | G
    | A
    | B


noteNameToString : NoteName -> String
noteNameToString n =
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


semitonesAboveC : NoteName -> Int
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


type alias NamedNote =
    { name : NoteName
    , modifier : Modifier
    , octave : Int
    }


toTone : NamedNote -> Tone
toTone nn =
    Tone
        (12
            * nn.octave
            + semitonesAboveC nn.name
            + (case nn.modifier of
                Flat ->
                    -1

                Natural ->
                    0

                Sharp ->
                    1
              )
        )


toNote : Tone -> NamedNote
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
    { name = name, modifier = modifier, octave = octave }


namedNoteToString : NamedNote -> String
namedNoteToString nn =
    noteNameToString nn.name ++ modifierToString nn.modifier
