module Event exposing (..)

import Gamer exposing (Gamer)
import Http

type Event
    --Gamer
    = FetchGamer (Int)
    | GotGamer (Result Http.Error Gamer)
    --Gamers
    | FetchGamers
    | GotGamers (Result Http.Error (List Gamer))
    --Post Gamer
    | FetchPost (String, String, String)
    | GotPosted (Result Http.Error ())
    --Delete Gamer
    | FetchDelete (Int)
    | GotDeleted (Result Http.Error ())
    --Input Values
    | Input1 (String)
    | Input2 (String)
    | Input3 (String)
    | Input4 (String)
    | Input5 (String)