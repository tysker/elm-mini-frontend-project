module View exposing (..)

import Browser
import Event exposing (Event(..))
import Gamer exposing (Gamer)
import Html exposing (..)
import Html.Attributes exposing (value)
import Html.Events exposing (..)
import Model exposing (Model)


view : Model -> Html Event
view model =
    div []
        [ text ("Gamers are:  ")
        , div []  (List.map showGamer model.gamers)
        , br [] []
        , br [] []
        , br [] []
        , input [value (String.fromInt model.id), onInput Input1] []
        , button [ onClick (FetchGamer (model.id))] [ text "Get Gamer" ]
        , button [ onClick (FetchGamers)] [ text "Get All Gamers" ]
        , br [] []
        , br [] []
        , input [value (String.fromInt(model.delete)), onInput Input2] []
        , button [onClick (FetchDelete (model.delete))] [text "Delete a person by ID"]
        , br [] []
        , br [] []
        --, input [value model, onInput Change] []
        --, button [onClick (FetchPost (model.name))] [text "Click this to POST a person "]
        --, input [value model.name, onInput Change] []
        ]

showGamer : Gamer -> Html Event
showGamer gamer =
    div[]
        [text ("nickname" ++ gamer.nickname)
        , br [] []
        , text ("score: " ++  String.fromInt gamer.score)
        , br [] []
        , text ("id: " ++ String.fromInt gamer.id)
        ]

getGamer: Maybe Gamer -> String
getGamer mp =
  case mp of
    Just gamer -> gamer.nickname++" id: "++(String.fromInt gamer.id)
    Nothing -> "No Gamer found. Try another Id!"