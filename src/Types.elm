module Types exposing (..)

import AssocList
import Browser
import Browser.Navigation as Nav
import List
import Url exposing (Url)


type alias Model =
    { route : Route
    , navKey : Nav.Key
    , quizStatuses : AssocList.Dict QuizID QuizStatus
    , demoCodeLang : DemoCodeLang
    }


type Msg
    = UserClickedLink Browser.UrlRequest
    | UrlHasChanged Url
    | QuizRecvInput QuizID QuizStatus
    | QuizErr
    | SelectDemoCodeLang DemoCodeLang
    | Ignore


type Route
    = Home
    | Part Int
    | More
    | NotFound


{-| A quiz can be identified by the route and order.

E.g. The 3rd quiz of /part/2

-}
type alias QuizID =
    ( Route, Int )


type QuizInput
    = QuizNoInput
    | QuizPass
    | QuizSel Int


type alias QuizStatus =
    { sel : QuizInput, sub : QuizInput }


type DemoCodeLang
    = Python
    | Haskell
