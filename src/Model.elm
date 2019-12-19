module Model exposing (..)

import Gamer exposing (Gamer)

type alias Model =
    { gamers: List Gamer
    , id: Int
    , delete: Int
    , event: String
    }