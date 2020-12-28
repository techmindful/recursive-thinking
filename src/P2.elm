module P2 exposing (p2)

import AssocList
import Consts exposing (..)
import Dict exposing (Dict)
import Element as ElmUI
import Element.Input as Input
import Html
import PageNavButtons exposing (..)
import Types exposing (..)


p2 : Model -> ElmUI.Element Msg
p2 model =
    let
        maybeQuizOneStatus =
            AssocList.get ( Part 2, 1 ) model.quizStatuses
    in
    case maybeQuizOneStatus of
        Nothing ->
            errGetQuizStatusPara

        Just quizOneStatus ->
            ElmUI.column []
                [ ElmUI.el [ ElmUI.paddingXY 0 20 ] <| prevPageButton model
                , ElmUI.textColumn
                    [ ElmUI.spacingXY 0 15 ]
                    [ ElmUI.paragraph []
                        [ ElmUI.text
                            "So if you ask me what's the factorial of n, I can just tell you it's n times the factorial of n - 1. This may be an interesting answer itself. But this definition has a fatal flaw. Do you want to figure out what it is?"
                        ]
                    ]
                , Input.radio
                    quizRadioStyle
                    { onChange =
                        \option ->
                            QuizRecvInput ( Part 2, 1 ) { sel = option, sub = quizOneStatus.sub }
                    , options =
                        [ Input.option QuizPass <| ElmUI.text "I'll pass."
                        , Input.option (QuizSel 1) <| ElmUI.paragraph [] [ ElmUI.text "Every time it answers what the factorial of an integer n is, a new question will be raised about what the factorial of (n - 1) is." ]
                        , Input.option (QuizSel 2) <| ElmUI.paragraph [] [ ElmUI.text "It's too simple and can't describe a complicated computation like factorial, which can involve a lot of numbers and multiplications." ]
                        ]
                    , selected = Just quizOneStatus.sel
                    , label = Input.labelAbove [] <| ElmUI.text ""
                    }
                , quizSubmitButton
                    (QuizRecvInput ( Part 2, 1 )
                        { sel = quizOneStatus.sel, sub = quizOneStatus.sel }
                    )
                    "Submit"
                , ElmUI.paragraph
                    [ ElmUI.paddingXY 0 15
                    , quizRespColor quizOneStatus 1
                    ]
                    [ ElmUI.text <|
                        case quizOneStatus.sub of
                            QuizSel 1 ->
                                "That is correct!"

                            QuizSel _ ->
                                "Simplicity doesn't mean incapability. Quite often simplicity is actually preferred in math and computer science!"

                            QuizPass ->
                                "No problem, here's the explanation:"

                            QuizNoInput ->
                                ""
                    ]
                ]
