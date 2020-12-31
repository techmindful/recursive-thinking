module P4 exposing (p4)

import AssocList
import Consts exposing (..)
import Element as ElmUI
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html
import List.Extra as List
import PageNavButtons exposing (..)
import Types exposing (..)


p4 : Model -> ElmUI.Element Msg
p4 model =
    let
        prevPageButton =
            ElmUI.el defaultPrevPageBtnStyle <| mkPrevPageButton model

        quiz1_RadioButtons quizOneStatus =
            Input.radio
                quizRadioStyle
                { onChange =
                    \option ->
                        QuizRecvInput ( Part 4, 1 ) { sel = option, sub = quizOneStatus.sub }
                , options =
                    [ Input.option (QuizSel 1) <| ElmUI.paragraph [] <| [ ElmUI.text "Figuring out how you should decide between driving forward and reach London, versus driving across middle street, then forward and reach London, when you are at the last intersection." ]
                    , Input.option (QuizSel 2) <| ElmUI.paragraph [] <| [ ElmUI.text "Figuring out how you should decide between driving forward, versus driving across middle street, then forward, when you are at the starting point." ]
                    , Input.option (QuizSel 3) <| ElmUI.paragraph [] <| [ ElmUI.text "Figuring out how you should decide between starting at A, versus starting at B." ]
                    , Input.option QuizNoInput <| ElmUI.text "I'll pass."
                    ]
                , selected = Just quizOneStatus.sel
                , label = Input.labelAbove [] <| ElmUI.text ""
                }
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
                    [ ElmUI.text "At each point, you can choose to either drive forward, or to drive sideway across the middle street, and then drive forward. The number on each segment is the time needed to drive through that segment. So for example, if you are at point C, you can choose to either spend 5 minutes driving to E, or spend 30 + 90 = 120 minutes driving to D, then to F. Do notice that although it's much faster to just drive to E, the segment EG costs a lot more time than the segment FH." ]
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
        , ElmUI.textColumn
            [ paraSpacing ]
            [ ElmUI.paragraph
                []
                [ ElmUI.text "When I saw this problem, I first attempted to solve it without recursion. And I wasn't even able to figure out where to start. The only thing I could think of is to just brute-force it, exhaust every possible path, and pick the one whose time sums up the least. That is to calculate the time needed of path A->C->E->G->J, and A->C->E->G->H->K, and A->C->E->F->H->K... And do the same again but starting at B. I felt like I need to be an algorithmic genius to come up with a better solution." ]
            , ElmUI.paragraph
                []
                [ ElmUI.text "But with recursion, I don't have to be a genius. I get to be the opposite of a genius, and solve it in a rather lazy way. Let's try the recursive approach together. As mentioned before, typically it's easier to figure out the base case in a recursion first, as it's usually also the most trivial case. What is the base case in this scenario?" ]
            ]
        ]
