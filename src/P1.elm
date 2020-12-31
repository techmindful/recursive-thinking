module P1 exposing (p1)

import AssocList
import Consts exposing (..)
import Element as ElmUI
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html
import PageNavButtons exposing (..)
import Types exposing (..)


p1 : Model -> ElmUI.Element Msg
p1 model =
    let
        maybeQuizOneStatus =
            AssocList.get ( Part 1, 1 ) model.quizStatuses
    in
    case maybeQuizOneStatus of
        Nothing ->
            errGetQuizStatusPara

        Just quizOneStatus ->
            ElmUI.column [] <|
                [ ElmUI.el defaultPrevPageBtnStyle <| mkPrevPageButton model
                , plainPara "The simplest example to explain recursion is factorial. Here's the traditional, \"iterative\" definition of what a factorial is:"
                , ElmUI.paragraph
                    [ ElmUI.paddingXY 40 20
                    , Font.italic
                    ]
                    [ ElmUI.text "The factorial of a positive integer n, denoted by n! , is the product of all the integers between n and 1. For example the factorial of 4, which is 4! , is just 4 * 3 * 2 * 1 = 24." ]
                , plainPara "To put it in a mathematical equation:"
                , ElmUI.paragraph
                    mathExpStyle
                    [ ElmUI.text "n! = n * (n - 1) * (n - 2) * ... * 1" ]
                , plainPara "Now that we know what a factorial is, we can actually define it with a new, recursive way. The recursive definition will define factorial with a factorial. Do you want to figure out which of the following equation is the correct one?"
                , Input.radio
                    quizRadioStyle
                    { onChange =
                        \option ->
                            QuizRecvInput ( Part 1, 1 ) { sel = option, sub = quizOneStatus.sub }
                    , options =
                        [ Input.option QuizPass <| ElmUI.text "I'll pass."
                        , Input.option (QuizSel 1) <| ElmUI.text "n! = n * (n - 1)! * (n - 2)! * ... * 1!"
                        , Input.option (QuizSel 2) <| ElmUI.text "n! = n * (n - 1)!"
                        ]
                    , selected = Just quizOneStatus.sel
                    , label = Input.labelAbove [] <| ElmUI.text ""
                    }
                , mkQuizSubmitButton
                    (QuizRecvInput ( Part 1, 1 )
                        { sel = quizOneStatus.sel, sub = quizOneStatus.sel }
                    )
                    "Submit"
                , ElmUI.paragraph
                    [ ElmUI.paddingXY 0 15
                    , quizRespColor quizOneStatus 2
                    ]
                    [ ElmUI.text <|
                        case quizOneStatus.sub of
                            QuizSel 2 ->
                                "That is correct!"

                            QuizSel _ ->
                                "That is incorrect. On paper, you can try to expand n!, (n - 1)!, and other terms, for a better comparison."

                            QuizPass ->
                                "No problem, here's the explanation:"

                            QuizNoInput ->
                                ""
                    ]
                ]
                    -- Display nothing unless user answers correctly, or passes.
                    ++ (if quizOneStatus.sub /= QuizSel 2 && quizOneStatus.sub /= QuizPass then
                            [ ElmUI.none ]

                        else
                            -- Quiz solution
                            [ ElmUI.textColumn []
                                [ plainPara "According to the traditional definition of factorial:"
                                , ElmUI.paragraph mathExpStyle
                                    [ ElmUI.text "(n - 1)! = (n - 1) * (n - 2) * ... * 1." ]
                                , plainPara "If we multiply by n at both sides, we get:"
                                , ElmUI.paragraph mathExpStyle
                                    [ ElmUI.text "n * (n - 1)! = n * (n - 1) * (n - 2) * ... * 1." ]
                                , plainPara "The right side is actually just n! ."
                                , ElmUI.paragraph
                                    [ ElmUI.paddingEach { top = 10, left = 0, right = 0, bottom = 0 } ]
                                    [ ElmUI.text "So we conclude:" ]
                                , ElmUI.paragraph mathExpStyle
                                    [ ElmUI.text "n! = n * (n - 1)!" ]
                                ]
                            , mkNextPageButton model
                            ]
                       )
