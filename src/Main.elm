module Main exposing (..)
--
--ELM PACKAGES
import Browser
import Event exposing (Event(..))
import Fetch exposing (deleteGamer, fetchGamer, fetchGamers, printError, postGamers)
--
--LOCAL IMPORTS
import Gamer as GA exposing (..)
import Model exposing (Model)
import View exposing (view)

fromJust : Maybe Int -> Int
fromJust x = case x of
    Just y -> y
    Nothing -> 0

init: () -> (Model, Cmd Event)
init _ = (Model [] 0 "" 0 0 "" , Cmd.none )
--init _ = Model({ gamers = , id = 0, nickname = "", score = "", delete = 0, event = ""})

update: Event -> Model -> (Model, Cmd Event)
update event model =
    case event of
        --Get one gamer
        FetchGamer (id) -> (model, fetchGamer id)
        (GotGamer (Ok gamer)) -> ({ model | gamers = [gamer]}, Cmd.none)
        (GotGamer (Err err)) -> ({ model | event = (printError err) }, Cmd.none)
        --Get all gamer
        FetchGamers -> (model, fetchGamers)
        GotGamers (Ok gamer) -> ({ model | gamers = gamer }, Cmd.none)
        GotGamers (Err err) -> ({ model | event = (printError err) }, Cmd.none)
        --Post Gamer
        FetchPost (id, nickname, score) -> (model, postGamers (id, nickname, score))
        GotPosted (Ok p) -> ( { model | event = ("Posted person successfully") } , Cmd.none)
        GotPosted (Err err) -> ({ model | event = (printError err) }, Cmd.none)
        --Delete Gamers
        FetchDelete (id) -> (model, deleteGamer (id))
        GotDeleted (Ok p) -> ( { model | event = ("Deleted person successfully.") } , Cmd.none)
        GotDeleted (Err err) -> ({ model | event = ("Attempted to Delete person failed.") }, Cmd.none)
        --Input Value
        Input1 (newContent) -> ({ model | id = fromJust (String.toInt(newContent))}, Cmd.none)
        Input2(newContent) -> ({ model | delete = fromJust (String.toInt(newContent))}, Cmd.none)
        Input3 (newContent) -> ({ model | nickname = newContent }, Cmd.none)
        Input4 (newContent) -> ({ model | score = fromJust (String.toInt(newContent)) }, Cmd.none)

noSubscriptions: Model -> Sub Event
noSubscriptions model =
  Sub.none

main : Program () Model Event
main = Browser.element
  { init = init
  , update = update
  , subscriptions = noSubscriptions
  , view = view
  }