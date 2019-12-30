module Main exposing (main)

import Browser
import Fretboard
import Html exposing (Html, div)
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
    ( { key = Key.makeKey Note.F Note.Sharp Scale.harmonicMinor
      , tuning = Tuning.standardSix
      , numFrets = 8
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
            IntervalColor.contrasting

        labels =
            labelAllNotes colorFn (Key.isInKey model.key) (Key.rootTone model.key) <| allTones model.tuning model.numFrets
    in
    Html.div [] [ Fretboard.view fretboard ]


labelAllNotes : DegreeColorFn -> (Note.Tone -> Bool) -> Note.Tone -> List ( Fretboard.Position, Note.Tone ) -> List Fretboard.Label
labelAllNotes colorFn highlight tonic tones =
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
