module Main exposing (main)

import Browser
import Color
import Fretboard exposing (Fretboard)
import Html exposing (Html, div)
import Note
import Scale
import Tuning exposing (Tuning)


type alias Msg =
    ()


type alias Model =
    { fretboard : Fretboard }


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
    let
        tuning =
            Tuning.standardSix

        numFrets =
            15

        numStrings =
            List.length tuning

        scale =
            Scale.major

        tonic =
            Note.toTone <| Note.Note Note.G Note.Natural 4

        isInScale tone =
            Scale.isSemitoneDegreeInScale scale (Note.semitoneDegree tonic tone)

        labels =
            labelAllNotes tonic <| List.filter (\( _, tone ) -> isInScale tone) <| allTones tuning numFrets
    in
    ( { fretboard =
            { numStrings = numStrings
            , numFrets = numFrets
            , labels = labels
            }
      }
    , Cmd.none
    )


labelAllNotes : Note.Tone -> List ( Fretboard.Position, Note.Tone ) -> List Fretboard.Label
labelAllNotes tonic tones =
    List.map
        (\( position, tone ) ->
            { position = position
            , color = Color.hsl (toFloat (Note.semitoneDegree tonic tone) / 12) 1 0.8
            , text = Note.noteToString (Note.toNote tone)
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


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update _ model =
    ( model, Cmd.none )


view : Model -> Html Msg
view model =
    Html.div [] [ Fretboard.view model.fretboard ]
