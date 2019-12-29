module Main exposing (main)

import Browser
import Color
import Fretboard exposing (Fretboard)
import Html exposing (Html, div)
import Note
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

        labels =
            labelAllNotes tuning numFrets
    in
    ( { fretboard =
            { numStrings = numStrings
            , numFrets = numFrets
            , labels = labels
            }
      }
    , Cmd.none
    )


labelAllNotes : Tuning -> Int -> List Fretboard.Label
labelAllNotes roots numFrets =
    let
        fretNote root s f =
            { position = { string = s, fret = f }
            , color = Color.rgb255 255 0 0
            , text = Note.noteToString <| Note.toNote <| Note.addSemitones root f
            }

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
