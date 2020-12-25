module Consts exposing (..)

import Element as ElmUI
import Element.Font as Font


homeUrlStr =
    "/"


moreUrlStr =
    "/more"


explainerUrlStrHead =
    "/part/"


maxPage =
    5


maxWidthPx =
    768


mathExpStyle =
    [ Font.center
    , ElmUI.paddingXY 0 36
    , Font.size 24
    ]


disabledColor =
    ElmUI.rgb255 128 128 128


quizCorrectColor =
    ElmUI.rgb255 0 255 0


quizWrongColor =
    ElmUI.rgb255 255 0 0


quizPassColor =
    ElmUI.rgb255 0 0 255
