module P1 exposing (p1)

import Consts exposing (..)
import Element as ElmUI
import Element.Border as Border
import Element.Input as Input
import Html
import Types exposing (..)


p1 : Model -> ElmUI.Element Msg
p1 model =
    ElmUI.column []
        [ ElmUI.textColumn
            [ ElmUI.spacingXY 0 15 ]
            [ ElmUI.paragraph []
                [ ElmUI.text "The simplest example to explain recursion is factorial. The factorial of a number n, denoted by n!, is just n * (n - 1) * (n - 2) * ... * 1. So the factorial of 4, which is 4!, equals to 24, because 4 * 3 * 2 * 1 = 24." ]
            , ElmUI.paragraph []
                [ ElmUI.text "The traditional, iterative way to calculate the n! is to just write out n, n - 1, n - 2... Until we reach 1. Then we multiply them together. The recursive way however, calculates factorial with a factorial. Do you want to figure out which of the following equation is the correct one?" ]
            ]
        , Input.radio
            [ ElmUI.padding 20
            , ElmUI.spacing 10
            ]
            { onChange = \option -> P1_RecvInput { sel = option, sub = model.p1_QuizStatus.sub }
            , options =
                [ Input.option (QuizSel 1) <| ElmUI.text "Wrong answer"
                , Input.option (QuizSel 2) <| ElmUI.text "Correct answer"
                , Input.option (QuizSel 3) <| ElmUI.text "Wrong answer 2"
                ]
            , selected = Just model.p1_QuizStatus.sel
            , label = Input.labelAbove [] <| ElmUI.text ""
            }
        , Input.button
            [ ElmUI.padding 6
            , Border.width 2
            , Border.rounded 6
            ]
            { onPress = Just <| P1_RecvInput { sel = model.p1_QuizStatus.sel, sub = model.p1_QuizStatus.sel }
            , label = ElmUI.text "Submit"
            }
        , ElmUI.text <|
            case model.p1_QuizStatus.sel of
                QuizSel 2 ->
                    "Correct sel"

                QuizSel n ->
                    "Wrong sel " ++ String.fromInt n

                _ ->
                    "Other"
        , ElmUI.text <|
            case model.p1_QuizStatus.sub of
                QuizSel 2 ->
                    "Correct sub"

                QuizSel n ->
                    "Wrong sub " ++ String.fromInt n

                _ ->
                    "Other"
        ]
