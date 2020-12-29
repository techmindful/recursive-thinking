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
        prevPageButton =
            ElmUI.el [ ElmUI.paddingXY 0 20 ] <| mkPrevPageButton model

        preQuiz1 =
            ElmUI.textColumn
                [ paraSpacing ]
                [ ElmUI.paragraph []
                    [ ElmUI.text
                        "So if you ask me what's the factorial of n, I can just tell you it's n times the factorial of n - 1. This may be an interesting answer itself. But this definition has a fatal flaw. Do you want to figure out what it is?"
                    ]
                ]

        quiz1_RadioButtons quizOneStatus =
            Input.radio
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

        quiz1_SubmitButton quizOneStatus =
            mkQuizSubmitButton
                (QuizRecvInput
                    ( Part 2, 1 )
                    { sel = quizOneStatus.sel, sub = quizOneStatus.sel }
                )
                "Submit"

        quiz1_Resp quizOneStatus =
            ElmUI.paragraph
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
                            "No problem. Second option is correct. Here's why:"

                        QuizNoInput ->
                            ""
                ]

        quiz1 quizOneStatus =
            ElmUI.column
                []
                [ quiz1_RadioButtons quizOneStatus
                , quiz1_SubmitButton quizOneStatus
                , quiz1_Resp quizOneStatus
                ]

        preQuiz2 =
            ElmUI.column
                []
                [ ElmUI.paragraph
                    []
                    [ ElmUI.text "If the entirety of the definition is just" ]
                , ElmUI.paragraph
                    mathExpStyle
                    [ ElmUI.text "n! = n * (n - 1)!" ]
                , ElmUI.paragraph []
                    [ ElmUI.text "Then imagine if we try to compute 4! ." ]
                , ElmUI.textColumn
                    [ ElmUI.paddingXY 40 20
                    , ElmUI.spacingXY 0 10
                    ]
                    [ ElmUI.paragraph []
                        [ ElmUI.text "4! = 4 * 3! . But what does 3! equal to?" ]
                    , ElmUI.paragraph []
                        [ ElmUI.text "3! = 3 * 2! . But what does 2! equal to?" ]
                    , ElmUI.paragraph []
                        [ ElmUI.text "2! = 2 * 1! . But what does 1! equal to?" ]
                    , ElmUI.paragraph []
                        [ ElmUI.text "1! = 1 * 0! . But what does 0! equal to?" ]
                    , ElmUI.paragraph []
                        [ ElmUI.text "0! = 0 * (-1)! . But what does..." ]
                    ]
                , ElmUI.textColumn
                    [ paraSpacing ]
                    [ ElmUI.paragraph []
                        [ ElmUI.text "Such a definition will be useless, because it never terminates. It's also incorrect in some sense. We will be multiplying negative numbers. And at the 5th step shown above, a 0 shows up in the multiplication, which means the result of any factorial will just be 0." ]
                    , ElmUI.paragraph []
                        [ ElmUI.text "But we can fix it with just one addition to our definition. Do you want to figure out what it is?" ]
                    ]
                ]

        quiz2_RadioButtons quizTwoStatus =
            Input.radio
                quizRadioStyle
                { onChange =
                    \option ->
                        QuizRecvInput ( Part 2, 2 )
                            { sel = option, sub = quizTwoStatus.sub }
                , options =
                    [ Input.option QuizPass <| ElmUI.text "I'll pass."
                    , Input.option (QuizSel 1) <|
                        ElmUI.text
                            "n! = n * (n - 1)! only when n - 1 is still a positive integer."
                    , Input.option (QuizSel 2) <|
                        ElmUI.text
                            "0! = 0"
                    , Input.option (QuizSel 3) <|
                        ElmUI.text
                            "1! = 1"
                    ]
                , selected = Just quizTwoStatus.sel
                , label = Input.labelAbove [] <| ElmUI.text ""
                }

        quiz2 quizTwoStatus =
            ElmUI.column
                []
                [ quiz2_RadioButtons quizTwoStatus
                ]

        afterQuiz1 =
            let
                maybeQuizTwoStatus =
                    AssocList.get ( Part 2, 2 ) model.quizStatuses
            in
            case maybeQuizTwoStatus of
                Nothing ->
                    ElmUI.none

                Just quizTwoStatus ->
                    ElmUI.column
                        []
                        [ preQuiz2
                        , quiz2 quizTwoStatus
                        ]
    in
    ElmUI.column
        []
    <|
        [ prevPageButton
        , preQuiz1
        ]
            ++ -- Quiz 1
               (let
                    maybeQuizOneStatus =
                        AssocList.get ( Part 2, 1 ) model.quizStatuses
                in
                case maybeQuizOneStatus of
                    Nothing ->
                        []

                    Just quizOneStatus ->
                        [ quiz1 quizOneStatus
                        , if quizOneStatus.sub == QuizPass || quizOneStatus.sub == QuizSel 1 then
                            afterQuiz1

                          else
                            ElmUI.none
                        ]
               )
