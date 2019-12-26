module Json exposing (..)

import Gamer exposing (Gamer)
import Json.Decode as JD exposing (Decoder, field, int, map3, string)
import Json.Encode as JE


--DECODERS
gamerDecoder: Decoder Gamer
gamerDecoder =
    map3 Gamer
        (field "id" int)
        (field "nickname" string)
        (field "score" int)

gamerListDecoder: Decoder (List Gamer)
gamerListDecoder = JD.list gamerDecoder

--ENCODERS
gamerEncoder: Gamer -> JE.Value
gamerEncoder gamer =
    JE.object
        [
          ("id" , JE.int gamer.id)
        , ("nickname" , JE.string gamer.nickname)
        , ("score" , JE.int gamer.score)
        ]