module P6 exposing (p6)

import AssocList
import Consts exposing (..)
import Element as ElmUI
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html
import Html.Attributes
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
                [ ElmUI.textColumn
                    [ paraSpacing ]
                    [ plainPara "This last page is for those among the readers who are interested in programming, and implementing our recursive solution into code."
                    , plainPara "Here's the street map again:"
                    , ElmUI.image
                        [ ElmUI.width ElmUI.fill ]
                        { src = "/static/img/heathrow-to-london.png"
                        , description = "WIP text for assistive technology"
                        }
                    , plainPara "We will be encoding all the time lengths of the segments into a list of integers. And they will come in triplets, in the order of left first, middle second, right third. For example, the time lengths of segments starting from G or H are [10, 25, 8]. The ones starting from E or F are [40, 20, 2, 10, 25, 8]. Starting from A or B, the complete list is [50, 0, 10, 5, 30, 90, 40, 20, 2, 10, 25, 8]."
                    , plainPara "The list of the time lengths of the segments ahead, added with a note on the side, are enough to describe an intersection. For example, point G is equivalent to (LeftSide, [10, 25, 8]). Point F is equivalent to (RightSide, [40, 20, 2, 10, 25, 8]). Point A is equivalent to (LeftSide, [50, 0, 10, 5, 30, 90, 40, 20, 2, 10, 25, 8])."
                    , plainPara "We are writing a recursive function that takes in a side, and a list of the time lengths of the segments ahead, and returns the least time needed to reach J or K."
                    ]
                , let
                    langSelButton lang labelStr =
                        Input.button
                            [ ElmUI.padding 6
                            , Border.width 2
                            , Border.rounded 6
                            ]
                            { onPress = Just <| SelectDemoCodeLang lang
                            , label = ElmUI.text labelStr
                            }
                  in
                  ElmUI.row
                    [ ElmUI.paddingXY 0 20
                    , ElmUI.spacingXY 15 0
                    ]
                    [ langSelButton Python "Python"
                    , langSelButton Haskell "Haskell"
                    , case model.demoCodeLang of
                        Python ->
                            ElmUI.none

                        Haskell ->
                            ElmUI.el
                                [ Font.size 18
                                , Font.color <| ElmUI.rgb255 80 80 80
                                ]
                                (ElmUI.text "Much less code..")
                    ]
                , ElmUI.textColumn
                    [ ElmUI.padding 20
                    , Border.width 2
                    , Border.rounded 6
                    ]
                    [ ElmUI.el
                        [ Font.size 16 ]
                        (ElmUI.html <|
                            Html.span [ Html.Attributes.style "white-space" "pre-wrap" ]
                                [ Html.text <|
                                    case model.demoCodeLang of
                                        Python ->
                                            pythonCode

                                        Haskell ->
                                            haskellCode
                                ]
                        )
                    ]
                , ElmUI.paragraph
                    [ ElmUI.paddingEach { top = 20, left = 0, right = 0, bottom = 0 } ]
                    [ ElmUI.text "Throw it into your compiler and see if it works!" ]
                ]
    in
    ElmUI.column
        []
        [ ElmUI.el defaultPrevPageBtnStyle <| mkPrevPageButton model
        , body
        , ElmUI.el defaultNextPageBtnStyle <| mkNextPageButton model
        ]
