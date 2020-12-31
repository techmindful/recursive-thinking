module P4 exposing (p4)

import Consts exposing (..)
import Element as ElmUI
import Element.Border as Border
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
            , ElmUI.image
                [ ElmUI.width ElmUI.fill ]
                { src = "/static/img/heathrow-to-london.png"
                , description = "WIP text for assistive technology"
                }
            , ElmUI.textColumn
                [ Border.width 2
                , Border.rounded 6
                , ElmUI.padding 12
                , paraSpacing
                ]
                [ ElmUI.paragraph
                    []
                    [ ElmUI.text "Heathrow is at the side of point A and point B. You can choose to start at either A or B. London is at the side of J and K. Arriving at either J or K completes the trip." ]
                , ElmUI.paragraph
                    []
                    [ ElmUI.text "At each point, you can choose to either drive up toward London, or to drive sideway across the middle street, and then drive up toward London. The number on each segment is the time needed to drive through that segment. So for example, if you are at point C, you can choose to either spend 5 minutes driving to E, or spend 30 + 90 = 120 minutes driving to D, then to F. Do notice that although it's much faster to just drive to E, the segment EG costs a lot more time than the segment FH." ]
                , ElmUI.paragraph
                    []
                    [ ElmUI.text "It makes sense to mark segment AB as costing 0 minute, because you can choose to start at either A or B. (So if you choose to start at A, you can choose to drive to C. Or you can choose to drive to B, then to D, which is equivalent of saying you chose to start at B.)" ]
                , ElmUI.paragraph
                    []
                    [ ElmUI.text "There exists a path where it costs you the least time to drive from Heathrow to London. The challenge is to compute how much time exactly does this path take." ]
                ]
            ]
        , ElmUI.paragraph
            [ ElmUI.paddingEach { top = 20, left = 0, right = 0, bottom = 40 } ]
            [ ElmUI.text "Feel free to try to solve this problem on your own for a bit, if you so desire. You can explore both recursive and iterative (non-recursive) approaches. When you're ready, the guide below will step you through the recursive solution." ]
        ]
