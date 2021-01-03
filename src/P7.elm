module P7 exposing (p7)

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


p7 : Model -> ElmUI.Element Msg
p7 model =
    let
        body =
            ElmUI.textColumn
                [ ElmUI.spacingXY 0 15 ]
                [ plainPara "That concludes the entirety of this explainer. I hope I didn't make it too dense. I hope you've not only learned what recursion is, but also learned a new mindset of problem-solving. A new way of thinking, in general."
                , ElmUI.paragraph
                    []
                    [ ElmUI.text "You can also check out "
                    , ElmUI.link
                        [ ElmUI.padding 4
                        , Border.width 2
                        , Border.rounded 6
                        ]
                        { url = moreUrlStr
                        , label = ElmUI.text "More"
                        }
                    , ElmUI.text " about recursion, functional programming, this website, and so on."
                    ]
                ]
    in
    ElmUI.column
        []
        [ ElmUI.el defaultPrevPageBtnStyle <| mkPrevPageButton model
        , body
        ]
