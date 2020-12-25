module Consts exposing (..)

import Element as ElmUI
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Types exposing (..)


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


{-| Apply this spacing in Element.paragraph for line spacing.

    Element.paragraph [ defaultLineSpacing, ... ] [ ... ]

-}
lineSpacing : ElmUI.Attribute Msg
lineSpacing =
    ElmUI.spacingXY 0 24


mathExpStyle =
    [ Font.center
    , ElmUI.paddingXY 0 36
    , Font.size 24
    ]


quizRadioStyle =
    [ ElmUI.padding 20
    , ElmUI.spacing 10
    ]


{-| Takes a Msg constructor. The constructor takes a QuizStatus and returns a Msg.
Then takes the current QuizStatus, and label string, to make and return a submit button.

    quizSubmitButton P1_RecvInput model.p1_QuizStatus "Submit"

-}
quizSubmitButton : (QuizStatus -> Msg) -> QuizStatus -> String -> ElmUI.Element Msg
quizSubmitButton recvInput qStatus labelStr =
    Input.button
        [ ElmUI.padding 6
        , Border.width 2
        , Border.rounded 6
        ]
        { onPress = Just <| recvInput { sel = qStatus.sel, sub = qStatus.sel }
        , label = ElmUI.text labelStr
        }


disabledColor =
    ElmUI.rgb255 128 128 128


quizCorrectColor =
    ElmUI.rgb255 0 255 0


quizWrongColor =
    ElmUI.rgb255 255 0 0


quizPassColor =
    ElmUI.rgb255 0 0 255


{-| Takes a quiz status, and the index of correct option,
Returns a font color attribute.

    quizRespColor model.p1_QuizStatus 2

-}
quizRespColor : QuizStatus -> Int -> ElmUI.Attribute Msg
quizRespColor qStatus correctOp =
    Font.color <|
        case qStatus.sub of
            QuizSel userSelection ->
                if userSelection == correctOp then
                    quizCorrectColor

                else
                    quizWrongColor

            QuizPass ->
                quizPassColor

            _ ->
                quizWrongColor
