module Gamer exposing (..)

type alias Gamer =
    { id : Int
    , nickname : String
    , score : Int
    }

type alias GamerModel =
    { gamer: Maybe Gamer
    , msg: String
    }