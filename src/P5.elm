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
        body =
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
                [ ElmUI.image
                    ([ ElmUI.width ElmUI.fill ] ++ stickyAttrs)
                    { src = "/static/img/heathrow-to-london.jpg"
                    , description = "WIP text for assistive technology"
                    }
                , plainPara "Let's execute our solution by hand, and see if it really works!"
                , plainPara "To reduce clutter, I'm going to abbreviate \"the quickest path from X to either J or K\" into \"Path_X\"."
                , qa
                    []
                    [ qPara "Q: So, what is Path_A?"
                    , aPara "A: Path_A is the quicker of these two: AC + Path_C, versus AB + BD + Path_D."
                    ]
                , qa
                    []
                    [ qPara "Q: But what is Path_C, and what is Path_D?"
                    , aPara "A: Path_C is the quicker of these two: CE + Path_E, versus CD + DF + Path_F."
                    , aPara "A: Path_D is the quicker of these two: DF + Path_F, versus CD + CE + Path_E."
                    ]
                , qa
                    []
                    [ qPara "Q: But what is Path_E, and what is Path_F?"
                    , aPara "A: Path_E is the quicker of these two: EG + Path_G, versus EF + FH + Path_H."
                    , aPara "A: Path_F is the quicker of these two: FH + Path_H, versus EF + EG + Path_G."
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
                    , qPara "Q: But what is Path_G, and what is Path_H?"
                    , aPara "A: Path_G is the quicker of these two: GJ, versus GH + HK. Since GJ takes 10 minutes, GH + HK takes 25 + 8 = 33 minutes, we conclude that Path_G is GJ, and it takes 10 minutes."
                    , aPara "A: Path_H is the quicker of these two: HK, versus GH + GJ. Since HK takes 8 minutes, GH + GJ takes 25 + 10 = 35 minutes, we conclude that Path_H is HK, and it takes 8 minutes."
                    ]
                , qa
                    []
                    [ plainPara "A: Since Path_E is the quicker of these two:"
                    , ElmUI.textColumn
                        vsOneTwoStyle
                        [ plainPara "1. EG + Path_G, which is just EG + GJ and takes 40 + 10 = 50 minutes;"
                        , plainPara "2. EF + FH + Path_H, which is just EF + FH + HK and takes 20 + 2 + 8 = 30 minutes."
                        ]
                    , aPara "Therefore, Path_E is EF + FH + HK. It takes 30 minutes."
                    ]
                , qa
                    []
                    [ plainPara "A: Since Path_F is the quicker of these two:"
                    , ElmUI.textColumn
                        vsOneTwoStyle
                        [ plainPara "1. FH + Path_H, which is just FH + HK and takes 2 + 8 = 10 minutes;"
                        , plainPara "2. EF + EG + Path_G, which is just EF + EG + GJ and takes 20 + 40 + 10 = 70 minutes."
                        ]
                    , aPara "Therefore, Path_F is FH + HK. It takes 10 minutes."
                    ]
                , qa
                    []
                    [ plainPara "A: Since Path_C is the quicker of these two:"
                    , ElmUI.textColumn
                        vsOneTwoStyle
                        [ plainPara "1. CE + Path_E, which is just CE + (EF + FH + HK) and takes 5 + 30 = 35 minutes;"
                        , plainPara "2. CD + DF + Path_F, which is just CD + DF + (FH + HK) and takes 30 + 90 + 10 = 130 minutes."
                        ]
                    , aPara "Therefore, Path_C is CE + EF + FH + HK. It takes 35 minutes."
                    ]
                , qa
                    []
                    [ plainPara
                        "A: Since Path_D is the quicker of these two:"
                    , ElmUI.textColumn
                        vsOneTwoStyle
                        [ plainPara "1. DF + Path_F, which is just DF + (FH + HK) and takes 90 + 10 = 100 minutes;"
                        , plainPara "2. CD + CE + Path_E, which is just CD + CE + (EF + FH + HK) and takes 30 + 5 + 30 = 65 minutes."
                        ]
                    , aPara "Therefore, Path_D is CD + CE + EF + FH + HK. It takes 65 minutes."
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
                    , plainPara "A: Since Path_A is the quicker of these two:"
                    , ElmUI.textColumn
                        vsOneTwoStyle
                        [ plainPara "1. AC + Path_C, which is just AC + (CE + EF + FH + HK) and takes 50 + 35 = 85 minutes;"
                        , plainPara "2. AB + BD + Path_D, which is just AB + BD + (CD + CE + EF + FH + HK) and takes 0 + 10 + 65 = 75 minutes."
                        ]
                    , plainPara "Therefore, Path_A, the quickest path from A to either J or K, is AB + BD + CD + CE + EF + FH + HK. It takes 75 minutes."
                    , aPara "And this path is equivalent to omitting AB (which takes 0 minute), starting at B, and going through BD + CD + CE + EF + FH + HK."
                    ]
                , plainPara "There we have it! The quickest path from Heathrow to London is to start from B, and go through BD + CD + CE + EF + FH + HK. It takes 75 minutes."
                , plainPara "Recursion actually works!"
                ]
    in
    ElmUI.column
        []
        [ ElmUI.el defaultPrevPageBtnStyle <| mkPrevPageButton model
        , body
        , ElmUI.el defaultNextPageBtnStyle <| mkNextPageButton model
        ]
