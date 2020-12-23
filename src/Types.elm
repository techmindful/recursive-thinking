module Types exposing (..)

import Browser
import Browser.Navigation as Nav
import Url exposing (Url)


type alias Model =
    { route : Route
    , navKey : Nav.Key
    , p1_QuizStatus : QuizStatus
    }


type Msg
    = UserClickedLink Browser.UrlRequest
    | UrlHasChanged Url
    | P1_RecvInput QuizStatus


type Route
    = Home
    | Part Int
    | More
    | NotFound


type QuizInput
    = QuizNoInput
    | QuizPass
    | QuizSel Int


type alias QuizStatus =
    { sel : QuizInput, sub : QuizInput }
