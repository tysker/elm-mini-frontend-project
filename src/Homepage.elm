module Homepage exposing (..)
--
--ELM PACKAGES
import Browser
import Html exposing (..)
import Html.Attributes exposing (value)
import Html.Events exposing (..)
import Http
import Json.Decode as JD exposing (Decoder, field, string, int, map3)
import Json.Encode as JE
--
--LOCAL IMPORTS
import Gamer as GA exposing (..)

type alias Model =
    { gamer: List Gamer
    , id: Int
    }


type Event
    = FetchGamer Int
    | GotGamers (Result Http.Error (List Gamer))
    | GotGamer (Result Http.Error Gamer)
    | Input1 (String)

fromJust : Maybe Int -> Int
fromJust x = case x of
    Just y -> y
    Nothing -> 0

init: () -> (Model, Cmd Event)
init _ = (Model [] 0, Cmd.none)

update: Event -> Model -> (Model, Cmd Event)
update event model =
    case event of
        FetchGamer (id) -> (model, fetchGamer id)

        (GotGamer (Ok gamer)) -> ({ model | gamer = [gamer]}, Cmd.none)

        Input1 (newContent) -> ({ model | id = fromJust (String.toInt(newContent))}, Cmd.none)


noSubscriptions: Model -> Sub Event
noSubscriptions model =
  Sub.none

getGamer: Maybe Gamer -> String
getGamer mp =
  case mp of
    Just gamer -> gamer.nickname++" id: "++(String.fromInt gamer.id)
    Nothing -> "No Gamer found. Try another Id!"

fetchGamer: Int -> Cmd Event
fetchGamer id =
  Http.request
    { method = "GET"
    , headers = []
    , url = "http://localhost:4711/member/" ++ (String.fromInt id)
    , body = Http.emptyBody
    , expect = Http.expectJson GotGamer gamerDecoder
    , timeout = Nothing
    , tracker = Nothing
    }

--fetchGamers: Cmd Event
--fetchGamers =
--  Http.request
--    { method = "GET"
--    , headers = []
--    , url = "http://localhost:4711/member"
--    , body = Http.emptyBody
--    , expect = Http.expectJson GotGamer gamerListDecoder
--    , timeout = Nothing
--    , tracker = Nothing
--    }

printError: Http.Error -> String
printError error =
  case error of
    Http.BadBody m -> "Bad body "++m
    Http.BadUrl u -> "Bad URL: "++u
    Http.Timeout -> "Timeout"
    Http.NetworkError -> "Network panic"
    Http.BadStatus i -> "Bad Status: "++(String.fromInt i)

--DECODERS
gamerDecoder: Decoder Gamer
gamerDecoder =
    map3 Gamer
        (field "id" int)
        (field "nickname" string)
        (field "score" int)

gamerListDecoder: Decoder (List Gamer)
gamerListDecoder =
    JD.list gamerDecoder

--ENCODERS
gamerEncoder: Gamer -> JE.Value
gamerEncoder gamer =
    JE.object
        [ ("id", JE.int gamer.id)
        , ("nickname" , JE.string gamer.nickname)
        , ("score" , JE.int gamer.score)
        ]

view : Model -> Html Event
view model =
    div []
        [ text ("Persons are:  ")
        , br [] []
        , input [value (String.fromInt model.id), onInput Input1] []
        , button [ onClick FetchGamer ] [ text "Get Gamer" ]
        , br [] []
        ]

main : Program () Model Event
main = Browser.element
  { init = init
  , update = update
  , subscriptions = noSubscriptions
  , view = view
  }