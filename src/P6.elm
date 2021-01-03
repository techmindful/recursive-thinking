module P6 exposing (p6)

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


p6 : Model -> ElmUI.Element Msg
p6 model =
    let
        body =
            ElmUI.column
                []
                [ plainPara "This last page is for those among the readers who are interested in programming, and implementing our recursive solution into code."
                ]
    in
    ElmUI.column
        []
        [ ElmUI.el defaultPrevPageBtnStyle <| mkPrevPageButton model
        , body
        , ElmUI.el defaultNextPageBtnStyle <| mkNextPageButton model
        ]
