module P1 exposing (p1)

import Element as ElmUI
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
            [ ElmUI.padding 10
            , ElmUI.spacing 20
            ]
            { onChange = \option -> P1_RecvInput option
            , options =
                [ Input.option Correct <| ElmUI.text "Correct answer"
                , Input.option Wrong1 <| ElmUI.text "Wrong answer 1"
                , Input.option Wrong2 <| ElmUI.text "Wrong answer 2"
                ]
            , selected = Just model.p1_UserChoice
            , label = Input.labelAbove [] <| ElmUI.text ""
            }
        ]
