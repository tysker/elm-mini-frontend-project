module Fetch exposing (..)

import Event exposing (..)
import Gamer exposing (Gamer)
import Http
import Json exposing (gamerDecoder, gamerListDecoder, gamerEncoder)

fetchGamer: Int -> Cmd Event
fetchGamer id =
  Http.request
    { method = "GET"
    , headers = []
    , url = "http://localhost:4711/gamer/" ++ (String.fromInt id)
    , body = Http.emptyBody
    , expect = Http.expectJson GotGamer gamerDecoder
    , timeout = Nothing
    , tracker = Nothing
    }

fetchGamers: Cmd Event
fetchGamers =
  Http.request
    { method = "GET"
    , headers = []
    , url = "http://localhost:4711/gamer"
    , body = Http.emptyBody
    , expect = Http.expectJson GotGamers gamerListDecoder
    , timeout = Nothing
    , tracker = Nothing
    }

deleteGamer: (Int) -> Cmd Event
deleteGamer (id) =
    Http.request
    { method = "DELETE"
    , headers = []
    , url = "http://localhost:4711/gamer/" ++ (String.fromInt id)
    , body = Http.emptyBody
    , expect = Http.expectWhatever GotDeleted
    , timeout = Nothing
    , tracker = Nothing
    }

postGamers: Int -> String -> Int -> Cmd Event
postGamers id nickname score =
  Http.request
    { method = "POST"
    , headers = []
    , url = "http://localhost:4711/gamer"
    , body = Http.jsonBody <| gamerEncoder (Gamer id nickname score)
    , expect = Http.expectWhatever GotPosted
    , timeout = Nothing
    , tracker = Nothing
    }

printError: Http.Error -> String
printError error =
  case error of
    Http.BadBody m -> "Bad body "++m
    Http.BadUrl u -> "Bad URL: "++u
    Http.Timeout -> "Timeout"
    Http.NetworkError -> "Network panic"
    Http.BadStatus i -> "Bad Status: "++(String.fromInt i)