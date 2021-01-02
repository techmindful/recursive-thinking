module Quiz exposing (..)

import AssocList
import Consts exposing (..)
import Element as ElmUI
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Tuple
import Types exposing (..)


{-| Takes a Msg constructor. The constructor takes a QuizStatus and returns a Msg.
Then takes the current QuizStatus, and label string, to make and return a submit button.

    mkQuizSubmitButton P1_RecvInput model.p1_QuizStatus "Submit"

-}
mkQuizSubmitButton : QuizID -> QuizStatus -> String -> ElmUI.Element Msg
mkQuizSubmitButton quizID qStatus labelStr =
    Input.button
        [ ElmUI.padding 6
        , Border.width 2
        , Border.rounded 6
        ]
        { onPress = Just <| QuizRecvInput quizID { sel = qStatus.sel, sub = qStatus.sel }
        , label = ElmUI.text labelStr
        }


getQuizStatus : Model -> QuizID -> QuizStatus
getQuizStatus model quizID =
    Maybe.withDefault dummyQuizStatus <|
        AssocList.get quizID model.quizStatuses


quizRadioStyle =
    [ ElmUI.padding 20
    , ElmUI.spacing 10
    ]


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


{-| Used in the unlikely case where model.quizStatuses look up fails
-}
dummyQuizStatus : QuizStatus
dummyQuizStatus =
    { sel = QuizNoInput, sub = QuizNoInput }


errGetQuizStatusPara : ElmUI.Element Msg
errGetQuizStatusPara =
    errPara "Error getting QuizStatus."


quizElOrErr : QuizID -> Maybe QuizStatus -> ElmUI.Element Msg -> ElmUI.Element Msg
quizElOrErr id maybeStatus el =
    case maybeStatus of
        Just s ->
            el

        Nothing ->
            errGetQuizStatusPara
