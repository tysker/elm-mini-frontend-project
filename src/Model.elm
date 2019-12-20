module Model exposing (..)

import Gamer exposing (..)

--gamerModel: GamerModel
type alias Model =
    { gamers: List Gamer
    , id: Int
    , nickname: String
    , score: Int
    , delete: Int
    , event: String
    }