module Ueben exposing (..)

import Browser
import Html exposing (..)

main : Program () Model msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }

type alias Person =
    {id: Int
    ,name: String
    ,age: Int
    }

type alias Model = Person

--The Init Function
{--
The init function can be considered the entry point of the application,
representing both the initial state (model) and any command that we want to
execute when the application starts.
--}

init : Model
init = Person 1 "Hans" 22

-- The update function
{--
The update function works with a message and a model as input and a tuple with a new model and
a command as output, usually, the output will depend on a message being processed.
--}
update : msg -> Model -> Model
update msg model = model


-- The View function
view : Model -> Html msg
view  model =
    div []
        [text ("Id: " ++ String.fromInt model.id)
        , br [] []
        , text ("Name: " ++ model.name)
        , br [] []
        , text ("Age: " ++ String.fromInt model.age)
        ]

