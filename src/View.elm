module View exposing (..)

import Event exposing (Event(..))
import Gamer exposing (Gamer)
import Html exposing (..)
import Html.Attributes exposing (placeholder, value)
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
        , input [placeholder "ID", value (String.fromInt(model.delete)), onInput Input2] []
        , button [onClick (FetchDelete (model.delete))] [text "Delete A Gamer By ID"]
        , br [] []
        , br [] []
        , input [ placeholder "ID", value (String.fromInt model.id), onInput Input5] []
        , input [ placeholder "Nickname", value model.nickname, onInput Input3] []
        , input [ placeholder "Score", value (String.fromInt model.score), onInput Input4] []
        , button [onClick (PostGamers (model.id, model.nickname, model.score))] [text "Add A Gamer "]
        ]

showGamer : Gamer -> Html Event
showGamer gamer =
    div[]
        [ text ("Nickname: " ++ gamer.nickname)
        , br [] []
        , text ("Score: " ++  String.fromInt gamer.score)
        , br [] []
        , text ("Id: " ++ String.fromInt gamer.id)
        ]

getGamer: Maybe Gamer -> String
getGamer mg =
  case mg of
    Just gamer -> gamer.nickname++" id: "++(String.fromInt gamer.id)
    Nothing -> "No Gamer found. Try another Id!"