module Main exposing (main)

import Browser
import Fretboard
import Html exposing (Html)
import IntervalColor exposing (DegreeColorFn)
import Key exposing (Key)
import Note
import Scale
import Tuning exposing (Tuning)


type alias Msg =
    ()


type alias Model =
    { key : Key
    , tuning : Tuning
    , numFrets : Int
    }


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { key = Key.makeKey Note.A Note.Natural Scale.major6Diminished
      , tuning = Tuning.standardSix
      , numFrets = 10
      }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update _ model =
    ( model, Cmd.none )


view : Model -> Html Msg
view model =
    let
        fretboard =
            { numStrings = List.length model.tuning
            , numFrets = model.numFrets
            , labels = labels
            }

        colorFn =
            IntervalColor.colorfulDistinct

        labels =
            labelNotes colorFn (Key.isInKey model.key) (Key.rootTone model.key) <| allTones model.tuning model.numFrets

        title =
            Key.keyName model.key
    in
    Html.div []
        [ Html.figure []
            [ Html.figcaption []
                [ Html.text title ]
            , Fretboard.view
                fretboard
            ]
        ]


labelNotes : DegreeColorFn -> (Note.Tone -> Bool) -> Note.Tone -> List ( Fretboard.Position, Note.Tone ) -> List Fretboard.Label
labelNotes colorFn highlight tonic tones =
    List.map
        (\( position, tone ) ->
            { position = position
            , color = colorFn (Note.semitoneDegree tonic tone)
            , text = Note.noteToString (Note.toNote tone)
            , highlight = highlight tone
            }
        )
        tones


allTones : Tuning -> Int -> List ( Fretboard.Position, Note.Tone )
allTones roots numFrets =
    let
        fretNote open s f =
            ( { string = s, fret = f }
            , Note.addSemitones open f
            )

        stringNotes n root =
            List.map (fretNote root (n + 1)) (List.range 0 numFrets)
    in
    List.concat <| List.indexedMap stringNotes roots
