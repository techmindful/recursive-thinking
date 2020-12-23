module Types exposing (..)

import Browser
import Browser.Navigation as Nav
import Url exposing (Url)


type alias Model =
    { route : Route
    , navKey : Nav.Key
    , p1_UserChoice : P1_Option
    }


type Msg
    = UserClickedLink Browser.UrlRequest
    | UrlHasChanged Url
    | P1_RecvInput P1_Option


type Route
    = Home
    | Part Int
    | More
    | NotFound


type P1_Option
    = Pending
    | Correct
    | Wrong1
    | Wrong2
