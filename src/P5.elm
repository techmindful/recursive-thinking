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
            in
            ElmUI.textColumn
                [ paraSpacing ]
                [ plainPara "Let's execute our solution by hand, and see if it really works! For reference, here's the picture of the street map:"
                , ElmUI.image
                    [ ElmUI.width ElmUI.fill ]
                    { src = "/static/img/heathrow-to-london.png"
                    , description = "WIP text for assistive technology"
                    }
                , qPara "Q: So, what is the quickest path from A, to either J or K?"
                , aParaEnd "A: The quickest path from A is whichever of the following two paths takes less time: AC followed by \"the quickest path starting from C\", versus AB + BD followed by \"the quickest path starting from D\"."
                , qPara "Q: But what is \"the quickest path starting from C\"? And what is \"the quickest path starting from D\"?"
                , aPara "A: \"The quickest path starting from C\" is whichever of the following two paths takes less time: CE followed by \"the quickest path starting from E\", versus CD + DF followed by \"the quickest path starting from F\"."
                , aParaEnd "A: And \"The quickest path starting from D\" is whichever of the following two paths takes less time: DF followed by \"the quickest path starting from F\", versus CD + DE followed by \"the quickest path starting from E\"."
                , qPara "Q: But what is \"the quickest path starting from E\", and what is \"the quickest path starting from F\"?"
                , aPara "A: \"The quickest path starting from E\" is ..."
                , ElmUI.paragraph
                    [ ElmUI.paddingXY 0 20 ]
                    [ ElmUI.text "......" ]
                , qPara "Q: But what is \"the quickest path starting from G\", and what is \"the quickest path starting from H\"?"
                , aPara "A: \"The quickest path starting from G\" is whichever of the following two paths takes less time: GJ, versus GH + HK. Since GJ takes 10 minutes, GH + HK takes 25 + 8 = 33 minutes, GJ is the quickest path starting from G."
                , aParaEnd "A: \"The quickest path starting from H\" is whichever of the following two paths takes less time: HK, versus GH + GJ. Since HK takes 8 minutes, GH + GJ takes 25 + 10 = 35 minutes, HK is the quickest path starting from H."
                , plainPara "A: Since \"the quickest path starting from E\" is whichever of the following two paths takes less time:"
                , ElmUI.textColumn
                    [ ElmUI.paddingXY 40 10
                    , ElmUI.spacingXY 0 20
                    ]
                    [ plainPara "1. EG followed by \"the quickest path starting from G\", which is actually EG + GJ and takes 40 + 10 = 50 minutes;"
                    , plainPara "2. EF + FH followed by \"the quickest path starting from H\", which is actually EF + FH + HK and takes 20 + 2 + 8 = 30 minutes."
                    ]
                , aParaEnd "Therefore, \"the quickest path starting from E\" is EF + FH + HK."
                , plainPara "A: Since \"the quickest path starting from F\" is whichever of the following two paths takes less time:"
                , ElmUI.textColumn
                    [ ElmUI.paddingXY 40 10
                    , ElmUI.spacingXY 0 20
                    ]
                    [ plainPara "1. FH followed by \"the quickest path starting from H\", which is actually FH + HK and takes 2 + 8 = 10 minutes;"
                    , plainPara "2. EF + EG followed by \"the quickest path starting from G\", which is actually EF + EG + GJ and takes 20 + 40 + 10 = 70 minutes."
                    ]
                , aParaEnd "Therefore, \"the quickest path starting from H\" is FH + HK."
                ]
    in
    ElmUI.column
        []
        [ ElmUI.el defaultPrevPageBtnStyle <| mkPrevPageButton model
        , preQuiz1
        ]
