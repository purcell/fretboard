module Main exposing (main)

import Browser
import Fretboard exposing (Fretboard)
import Html exposing (Html, div)
import IntervalColor exposing (DegreeColorFn)
import Key exposing (Key)
import Note
import Scale
import Tuning exposing (Tuning)


type alias Msg =
    ()


type alias Model =
    { fretboard : Fretboard
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
    let
        tuning =
            Tuning.standardSix

        numFrets =
            15

        key =
            Key.makeKey Note.F Note.Sharp Scale.harmonicMinor

        colorFn =
            IntervalColor.contrasting

        labels =
            labelAllNotes colorFn (Key.isInKey key) (Key.rootTone key) <| allTones tuning numFrets
    in
    ( { fretboard =
            { numStrings = List.length tuning
            , numFrets = numFrets
            , labels = labels
            }
      }
    , Cmd.none
    )


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


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update _ model =
    ( model, Cmd.none )


view : Model -> Html Msg
view model =
    Html.div [] [ Fretboard.view model.fretboard ]
