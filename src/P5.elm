module P5 exposing (p5)

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


p5 : Model -> ElmUI.Element Msg
p5 model =
    let
        preQuiz1 =
            let
                qPara =
                    plainPara

                aPara =
                    plainPara

                aParaEnd str =
                    ElmUI.paragraph
                        [ ElmUI.paddingEach { top = 0, right = 0, left = 0, bottom = 20 } ]
                        [ ElmUI.text str ]

                vsOneTwoStyle =
                    [ ElmUI.paddingXY 40 10
                    , ElmUI.spacingXY 0 20
                    ]

                qa style elements =
                    ElmUI.textColumn
                        (style
                            ++ [ ElmUI.paddingXY 10 10
                               , ElmUI.spacingXY 0 20
                               , Border.width 2
                               , Border.rounded 6
                               ]
                        )
                        elements
            in
            ElmUI.textColumn
                [ paraSpacing ]
                [ plainPara "Let's execute our solution by hand, and see if it really works! For reference, here's the picture of the street map:"
                , ElmUI.image
                    [ ElmUI.width ElmUI.fill ]
                    { src = "/static/img/heathrow-to-london.png"
                    , description = "WIP text for assistive technology"
                    }
                , qa
                    []
                    [ qPara "Q: So, what is the quickest path from A, to either J or K?"
                    , aPara "A: The quickest path from A is whichever of the following two paths takes less time: AC followed by \"the quickest path starting from C\", versus AB + BD followed by \"the quickest path starting from D\"."
                    ]
                , qa
                    []
                    [ qPara "Q: But what is \"the quickest path starting from C\"? And what is \"the quickest path starting from D\"?"
                    , aPara "A: \"The quickest path starting from C\" is whichever of the following two paths takes less time: CE followed by \"the quickest path starting from E\", versus CD + DF followed by \"the quickest path starting from F\"."
                    , aPara "A: And \"The quickest path starting from D\" is whichever of the following two paths takes less time: DF followed by \"the quickest path starting from F\", versus CD + DE followed by \"the quickest path starting from E\"."
                    ]
                , qa
                    []
                    [ qPara "Q: But what is \"the quickest path starting from E\", and what is \"the quickest path starting from F\"?"
                    , aPara "A: \"The quickest path starting from E\" is whichever of the following two paths takes less time: EG followed by \"the quickest path starting from G\", versus EF + FH followed by \"the quickest path starting from H."
                    , aPara "A: And \"the quickest path starting from F\" is whichever of the following two paths takes less time: FH followed by \"the quickest path starting from H\", versus EF + EG followed by \"the quickest path starting from G\"."
                    ]

                -- Base case
                , ElmUI.textColumn
                    [ ElmUI.paddingXY 10 10
                    , ElmUI.spacingXY 0 20
                    , Border.width 4
                    , Border.rounded 5
                    , Border.color <| ElmUI.rgb255 47 158 91
                    ]
                    [ ElmUI.paragraph
                        [ Font.size 24
                        , Font.bold
                        , Font.color <| ElmUI.rgb255 47 158 91
                        ]
                        [ ElmUI.text "Base case!" ]
                    , qPara "Q: But what is \"the quickest path starting from G\", and what is \"the quickest path starting from H\"?"
                    , aPara "A: \"The quickest path starting from G\" is whichever of the following two paths takes less time: GJ, versus GH + HK. Since GJ takes 10 minutes, GH + HK takes 25 + 8 = 33 minutes, GJ is the quickest path starting from G."
                    , aPara "A: \"The quickest path starting from H\" is whichever of the following two paths takes less time: HK, versus GH + GJ. Since HK takes 8 minutes, GH + GJ takes 25 + 10 = 35 minutes, HK is the quickest path starting from H."
                    ]
                , qa
                    []
                    [ plainPara "A: Since \"the quickest path starting from E\" is whichever of the following two paths takes less time:"
                    , ElmUI.textColumn
                        vsOneTwoStyle
                        [ plainPara "1. EG followed by \"the quickest path starting from G\", which is actually EG + GJ and takes 40 + 10 = 50 minutes;"
                        , plainPara "2. EF + FH followed by \"the quickest path starting from H\", which is actually EF + FH + HK and takes 20 + 2 + 8 = 30 minutes."
                        ]
                    , aPara "Therefore, \"the quickest path starting from E\" is EF + FH + HK. It takes 30 minutes."
                    ]
                , qa
                    []
                    [ plainPara "A: Since \"the quickest path starting from F\" is whichever of the following two paths takes less time:"
                    , ElmUI.textColumn
                        vsOneTwoStyle
                        [ plainPara "1. FH followed by \"the quickest path starting from H\", which is actually FH + HK and takes 2 + 8 = 10 minutes;"
                        , plainPara "2. EF + EG followed by \"the quickest path starting from G\", which is actually EF + EG + GJ and takes 20 + 40 + 10 = 70 minutes."
                        ]
                    , aPara "Therefore, \"the quickest path starting from H\" is FH + HK. It takes 10 minutes."
                    ]
                , qa
                    []
                    [ plainPara "A: Since \"the quickest path starting from C\" is whichever of the following two paths takes less time:"
                    , ElmUI.textColumn
                        vsOneTwoStyle
                        [ plainPara "1. CE followed by \"the quickest path starting from E\", which is actually CE + (EF + FH + HK) and takes 5 + 30 = 35 minutes;"
                        , plainPara "2. CD + DF followed by \"the quickest path starting from F\", which is actually CD + DF + (FH + HK) and takes 30 + 90 + 10 = 130 minutes."
                        ]
                    , aPara "Therefore, \"the quickest path starting from C\" is CE + EF + FH + HK. It takes 35 minutes."
                    ]
                , qa
                    []
                    [ plainPara
                        "A: Since \"the quickest path starting from D\" is whichever of the following two paths takes less time:"
                    , ElmUI.textColumn
                        vsOneTwoStyle
                        [ plainPara "1. DF followed by \"the quickest path starting from F\", which is actually DF + (FH + HK) and takes 90 + 10 = 100 minutes;"
                        , plainPara "2. CD + CE followed by \"the quickest path starting from E\", which is actually CD + CE + (EF + FH + HK) and takes 30 + 5 + 30 = 65 minutes."
                        ]
                    , aPara "Therefore, \"the quickest path starting from D\" is CD + CE + EF + FH + HK. It takes 65 minutes."
                    ]

                -- Final answer
                , ElmUI.textColumn
                    [ ElmUI.paddingXY 10 10
                    , ElmUI.spacingXY 0 20
                    , Border.width 4
                    , Border.rounded 5
                    , Border.color <| ElmUI.rgb255 47 158 91
                    ]
                    [ ElmUI.paragraph
                        [ Font.size 24
                        , Font.bold
                        , Font.color <| ElmUI.rgb255 47 158 91
                        ]
                        [ ElmUI.text "Final answer!" ]
                    , plainPara "A: Since \"the quickest path starting from A\" is whichever of the following two paths takes less time:"
                    , ElmUI.textColumn
                        vsOneTwoStyle
                        [ plainPara "1. AC followed by \"the quickest path starting from C\", which is actually AC + (CE + EF + FH + HK) and takes 50 + 35 = 85 minutes;"
                        , plainPara "2. AB + BD followed by \"the quickest path starting from D\", which is actually AB + BD + (CD + CE + EF + FH + HK) and takes 0 + 10 + 65 = 75 minutes."
                        ]
                    , plainPara "Therefore, \"the quickest path starting from A\" is AB + BD + CD + CE + EF + FH + HK. It takes 75 minutes."
                    , aPara "And this path is equivalent to starting from B, taking AB (which takes 0 minute) out, and going through BD + CD + CE + EF + FH + HK."
                    ]
                , plainPara "There we have it! The quickest path from Heathrow to London is to start from B, and go through BD + CD + CE + EF + FH + HK. It takes 75 minutes. Recursion actually works!"
                ]
    in
    ElmUI.column
        []
        [ ElmUI.el defaultPrevPageBtnStyle <| mkPrevPageButton model
        , preQuiz1
        ]
