module Consts exposing (..)

import Element as ElmUI
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Tuple
import Types exposing (..)


homeUrlStr =
    "/"


moreUrlStr =
    "/more"


explainerUrlStrHead =
    "/part/"


maxPage =
    6


maxWidthPx =
    768


plainPara : String -> ElmUI.Element Msg
plainPara str =
    ElmUI.paragraph
        []
        [ ElmUI.text str ]


{-| Apply this spacing in Element.paragraph for line spacing.

    Element.paragraph [ defaultLineSpacing, ... ] [ ... ]

-}
lineSpacing : ElmUI.Attribute Msg
lineSpacing =
    ElmUI.spacingXY 0 24


paraSpacing : ElmUI.Attribute Msg
paraSpacing =
    ElmUI.spacingXY 0 15


mathExpStyle : List (ElmUI.Attribute Msg)
mathExpStyle =
    [ Font.center
    , ElmUI.paddingXY 0 36
    , Font.size 24
    ]


multiMathExpStyle : List (ElmUI.Attribute Msg)
multiMathExpStyle =
    [ ElmUI.paddingXY 40 36
    , ElmUI.spacingXY 0 10
    , Font.size 24
    ]


disabledColor =
    ElmUI.rgb255 128 128 128


errPara : String -> ElmUI.Element m
errPara errMsg =
    ElmUI.paragraph []
        [ ElmUI.text <|
            "Error: I made a mistake when making this website. I was about to blame javascript but I remembered I'm using Elm.. Can you contact me about this? "
                ++ "ErrMsg: \""
                ++ errMsg
                ++ "\""
        ]
