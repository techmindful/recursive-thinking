module P4 exposing (p4)

import Consts exposing (..)
import Element as ElmUI
import Element.Font as Font
import Element.Input as Input
import Html
import PageNavButtons exposing (..)
import Types exposing (..)


p4 : Model -> ElmUI.Element Msg
p4 model =
    let
        prevPageButton =
            ElmUI.el defaultPrevPageBtnStyle <| mkPrevPageButton model
    in
    ElmUI.column
        []
    <|
        [ prevPageButton
        , ElmUI.textColumn
            [ paraSpacing ]
            [ ElmUI.paragraph
                []
                [ ElmUI.text "At this point you may be thinking: Well all of this is fun, or even artistic. But does this have any practical use?" ]
            , ElmUI.paragraph
                []
                [ ElmUI.text "Let me present you the problem named \"Heathrow to London\". Imagine that you've just arrived at the Heathrow airport, and you need to drive to London. Below is the street map:" ]
            ]
        ]
