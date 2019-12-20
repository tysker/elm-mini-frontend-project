module Model exposing (..)

import Gamer exposing (..)

--gamerModel: GamerModel
type alias Model =
    { gamers: List Gamer
    , id: Int
    , nickname: String
    , score: String
    , delete: Int
    , event: String
    }