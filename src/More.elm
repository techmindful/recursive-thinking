module More exposing (more)

import AssocList
import Consts exposing (..)
import Element as ElmUI
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html
import List.Extra as List
import PageNavButtons exposing (..)
import Quiz exposing (..)
import Types exposing (..)


more : ElmUI.Element Msg
more =
    ElmUI.column
        [ ElmUI.spacingXY 0 40 ]
        [ ElmUI.textColumn
            [ ElmUI.spacingXY 0 10 ]
            [ plainPara "The author of this website is: Me."
            , plainPara "The tool used to build this website is: Elm."
            ]
        , ElmUI.textColumn
            []
            [ plainPara "Recursion is also a key concept in functional programming."
            ]
        ]
