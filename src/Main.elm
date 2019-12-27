module Main exposing (main)

import Browser
import Fretboard exposing (Fretboard)
import Html exposing (Html, button, div, text)


type Msg
    = NoOp


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
    ( { fretboard = Fretboard.default }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update _ model =
    ( model, Cmd.none )


view : Model -> Html Msg
view model =
    Html.div [] [ Fretboard.view model.fretboard ]
