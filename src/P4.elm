module P4 exposing (p4)

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


p4 : Model -> ElmUI.Element Msg
p4 model =
    let
        quizOneStatus =
            getQuizStatus model ( Part 4, 1 )

        quizTwoStatus =
            getQuizStatus model ( Part 4, 2 )

        quizThreeStatus =
            getQuizStatus model ( Part 4, 3 )

        quizFourStatus =
            getQuizStatus model ( Part 4, 4 )

        prevPageButton =
            ElmUI.el defaultPrevPageBtnStyle <| mkPrevPageButton model

        preQuiz1 =
            ElmUI.column
                []
                [ prevPageButton
                , ElmUI.textColumn
                    [ paraSpacing ]
                    [ plainPara "At this point you may be thinking: Well all of this is fun, or even artistic. But does this have any practical use?"
                    , plainPara "Let me present you the problem named \"Heathrow to London\". Imagine that you've just arrived at the Heathrow airport, and you need to drive to London. Below is the street map:"
                    , ElmUI.image
                        [ ElmUI.width ElmUI.fill ]
                        { src = "/static/img/heathrow-to-london.png"
                        , description = "WIP text for assistive technology"
                        }
                    , ElmUI.textColumn
                        [ Border.width 2
                        , Border.rounded 6
                        , ElmUI.padding 12
                        , paraSpacing
                        ]
                        [ plainPara "Heathrow is at the side of point A and point B. You can choose to start at either A or B. London is at the side of J and K. Arriving at either J or K completes the trip."
                        , plainPara "At each point, you can choose to either drive forward, or to drive sideway across the middle street, and then drive forward. The number on each segment is the time needed to drive through that segment. So for example, if you are at point C, you can choose to either spend 5 minutes driving to E, or spend 30 + 90 = 120 minutes driving to D, then to F. Do notice that although it's much faster to just drive to E, the segment EG costs a lot more time than the segment FH."
                        , plainPara "It makes sense to mark segment AB as costing 0 minute, because you can choose to start at either A or B. (So if you choose to start at A, you can choose to drive to C. Or you can choose to drive to B, then to D, which is equivalent of saying you chose to start at B.)"
                        , plainPara "There exists a path where it costs you the least time to drive from Heathrow to London. The challenge is to compute how much time exactly does this path take."
                        ]
                    ]
                , ElmUI.paragraph
                    [ ElmUI.paddingEach { top = 20, left = 0, right = 0, bottom = 40 } ]
                    [ ElmUI.text "Feel free to try to solve this problem on your own for a bit, if you so desire. You can explore both recursive and iterative (non-recursive) approaches. When you're ready, the guide below will step you through the recursive solution." ]
                , ElmUI.textColumn
                    [ paraSpacing ]
                    [ plainPara "When I saw this problem, I first attempted to solve it without recursion. The only thing I could think of is to just brute-force it, exhaust every possible path, and pick the one whose time sums up the least. That is to calculate the time needed of path A->C->E->G->J, and A->C->E->G->H->K, and A->C->E->F->H->K... Sure, that works. But it didn't feel easy to translate that process to a computer program. Can it be done more pleasantly?"
                    , plainPara "It turned out that with recursion, I can solve it in a rather lazy manner. Let's try it together. As mentioned before, typically it's easier to figure out the base case in a recursion first, as it's usually also the most trivial case. What is the base case in this scenario?"
                    ]
                ]

        quiz1_RadioButtons qStatus =
            Input.radio
                quizRadioStyle
                { onChange =
                    \option ->
                        QuizRecvInput ( Part 4, 1 ) { sel = option, sub = qStatus.sub }
                , options =
                    [ Input.option (QuizSel 1) <| ElmUI.paragraph [] <| [ ElmUI.text "Figuring out how to decide between driving forward and reach London, versus driving across middle street, then forward and reach London, when you are at the last intersection (either G or H)." ]
                    , Input.option (QuizSel 2) <| ElmUI.paragraph [] <| [ ElmUI.text "Figuring out how to decide between driving forward, versus driving across middle street, then forward, when you are at the starting point (either A or B)." ]
                    , Input.option (QuizSel 3) <| ElmUI.paragraph [] <| [ ElmUI.text "Figuring out how to decide between starting at A, versus starting at B." ]
                    , Input.option QuizPass <| ElmUI.text "I'll pass."
                    ]
                , selected = Just qStatus.sel
                , label = Input.labelAbove [] <| ElmUI.text ""
                }

        quiz1_SubmitButton qStatus =
            mkQuizSubmitButton ( Part 4, 1 ) qStatus "Submit"

        quiz1_Resp qStatus =
            ElmUI.paragraph
                [ ElmUI.paddingXY 0 15
                , quizRespColor qStatus 1
                ]
                [ case qStatus.sub of
                    QuizSel 1 ->
                        ElmUI.text "That is correct!"

                    QuizSel 2 ->
                        plainPara "Think again. It's not trivial to have this figured out. Remember that the base case is usually the most trivial (easiest) case. It's also usually the last step in the recursion."

                    QuizSel _ ->
                        plainPara "This doesn't need to be figured out. We can just solve the case where we start at A. If the final solution is a path like A->B->D->... We can just omit the A->B part. It takes 0 minute, and it's equivalent to saying the path starts at B."

                    QuizPass ->
                        plainPara "No problem. The first option is correct. Here's why:"

                    QuizNoInput ->
                        ElmUI.none
                ]

        quiz1 =
            ElmUI.column
                []
                [ quiz1_RadioButtons quizOneStatus
                , quiz1_SubmitButton quizOneStatus
                , quiz1_Resp quizOneStatus
                ]

        postQuiz1 =
            ElmUI.column
                []
                [ preQuiz2
                , quiz2
                , if quizTwoStatus.sub == QuizSel 2 then
                    postQuiz2

                  else
                    ElmUI.none
                ]

        preQuiz2 =
            ElmUI.column
                []
                [ plainPara "Despite the whole problem being difficult, when we've reached the last intersection (either G or H), the one last choice we need to make is fairly simple. If we are already at G, then we should just go along segment GJ, which will take us 10 minutes. If we are already at H, then we should just go along HK, which will take us 8 minutes. What's the reasoning behind this strategy?" ]

        quiz2_RadioButtons qStatus =
            Input.radio
                quizRadioStyle
                { onChange =
                    \option ->
                        QuizRecvInput ( Part 4, 2 ) { sel = option, sub = qStatus.sub }
                , options =
                    [ Input.option (QuizSel 1) <| plainPara "In either case, the destination is just straight ahead. No need to cross the middle street."
                    , Input.option (QuizSel 2) <| plainPara "In either case, it takes more time to cross the middle street and go forward on the other side, than to go forward on the current side."
                    ]
                , selected = Just qStatus.sel
                , label = Input.labelAbove [] ElmUI.none
                }

        quiz2_SubmitButton qStatus =
            mkQuizSubmitButton ( Part 4, 2 ) qStatus "Submit"

        quiz2_Resp qStatus =
            ElmUI.paragraph
                [ ElmUI.paddingXY 0 15
                , quizRespColor qStatus 2
                ]
                [ case qStatus.sub of
                    QuizSel 1 ->
                        plainPara "Don't be tricked here! Imagine if segment GJ takes 50 minutes, rather than just 10. Then it's much quicker to cross the middle street, then go forward on the other side, as it only takes 25 + 8 = 33 minutes."

                    QuizSel 2 ->
                        plainPara "Precisely!"

                    _ ->
                        ElmUI.none
                ]

        quiz2 =
            ElmUI.column
                []
                [ quiz2_RadioButtons quizTwoStatus
                , quiz2_SubmitButton quizTwoStatus
                , quiz2_Resp quizTwoStatus
                ]

        postQuiz2 =
            ElmUI.column
                []
                [ preQuiz3
                , quiz3
                , if quizThreeStatus.sub == QuizSel 1 || quizThreeStatus.sub == QuizPass then
                    postQuiz3

                  else
                    ElmUI.none
                ]

        preQuiz3 =
            ElmUI.textColumn
                [ paraSpacing ]
                [ plainPara "Let's verbalize this strategy: At the last intersection, if we are on the left side, the quickest path is whichever of these two takes less time: Going through left segment, versus going through middle segment, then right segment."
                , plainPara "And it's similar if we are on the right side. The quickest path is whichever of these two takes less time: Going through right segment, versus going through middle segment, then left segment."
                , plainPara "Now let's tackle the more general, recursive case. With the solution of the base case at hand, can you answer the question \"At any intersection, what's the quickest path from there to reach London\"? Remember that in recursion, you can answer a question with a question!"
                ]

        quiz3_RadioButtons qStatus =
            let
                optionStyle =
                    ElmUI.textColumn
                        [ ElmUI.padding 15
                        , ElmUI.spacingXY 0 5
                        , Border.width 2
                        , Border.rounded 6
                        ]
            in
            Input.radio
                quizRadioStyle
                { onChange =
                    \option ->
                        QuizRecvInput ( Part 4, 3 ) { sel = option, sub = qStatus.sub }
                , options =
                    [ Input.option (QuizSel 1) <|
                        optionStyle
                            [ plainPara "If we are at an intersection on the left side, then the quickest path from there is whichever of the following two is quicker:"
                            , ElmUI.paragraph [ ElmUI.paddingXY 20 0 ] [ ElmUI.text "1. Going through left segment to reach the next intersection, and then going through \"the quickest path from that intersection to reach London\"." ]
                            , ElmUI.paragraph [ ElmUI.paddingXY 20 0 ] [ ElmUI.text "2. Going through middle segment, then right segment, to reach the next intersection, and then going through \"the quickest path from that intersection to reach London\"." ]
                            , plainPara "It's similar if we are on the right side."
                            ]
                    , Input.option (QuizSel 2) <|
                        optionStyle
                            [ plainPara "If we are at an intersection on the left side, then the quickest path from there is going through the middle segment first, and then going through whichever of the following two is quicker:"
                            , ElmUI.paragraph [ ElmUI.paddingXY 20 0 ] [ ElmUI.text "1. Going through left segment to reach the next intersection, and then going through \"the quickest path from that intersection to reach London\"." ]
                            , ElmUI.paragraph [ ElmUI.paddingXY 20 0 ] [ ElmUI.text "2. Going through right segment to reach the next intersection, and then going through \"the quickest path from that intersection to reach London\"." ]
                            , plainPara "It's similar if we are on the right side."
                            ]
                    , Input.option QuizPass <| plainPara "I'll pass."
                    ]
                , selected = Just qStatus.sel
                , label = Input.labelAbove [] <| ElmUI.none
                }

        quiz3_SubmitButton qStatus =
            mkQuizSubmitButton ( Part 4, 3 ) qStatus "Submit"

        quiz3_Resp qStatus =
            ElmUI.paragraph
                [ ElmUI.paddingXY 0 15
                , quizRespColor qStatus 1
                ]
                [ case qStatus.sub of
                    QuizSel 1 ->
                        ElmUI.text "That is correct!"

                    QuizSel 2 ->
                        ElmUI.text "This one doesn't make sense. It's saying we are always going through the middle segment. Starting from the left side, it means we'll then end up on the right side. But then if \"whichever of the following two is quicker\" turns out to be \"1. Going through left segment to ...\", we'd find ourselves having to teleport back to the left side!"

                    QuizPass ->
                        ElmUI.text "No problem. For now, know that the first option is correct."

                    _ ->
                        ElmUI.none
                ]

        quiz3 =
            ElmUI.column
                []
                [ quiz3_RadioButtons quizThreeStatus
                , quiz3_SubmitButton quizThreeStatus
                , quiz3_Resp quizThreeStatus
                ]

        postQuiz3 =
            ElmUI.column
                []
                [ ElmUI.textColumn
                    [ paraSpacing ]
                    [ plainPara "And... That's it! That describes our entire strategy!"
                    , plainPara "For real. At any intersection, we have a definitive way to find out the quickest path. Even though it'll lead us to a new question, eventually we'll find ourselves reaching one of the last intersections (G or H). And from the base case, we know the quickest path from there. That in turn gives answer to the previous question, which gives answer to the previous question of the previous question, ... Eventually, the original question is answered."
                    , plainPara "If you are not so convinced that a lazy, or even cheating way of problem-solving can actually work, then the following pages will go through the strategy step by step, to verify the recursion is correct."
                    ]
                , ElmUI.el [ ElmUI.paddingXY 0 20 ] <| mkNextPageButton model
                ]

        preQuiz4 =
            ElmUI.column
                []
                [ ElmUI.textColumn
                    [ paraSpacing ]
                    [ plainPara "Now let's think of it this way: We're writing the solution of this problem as a function called f. If we tell f our current point, f should be able to tell us the least time needed to reach London from where we are."
                    , plainPara "To give f the complete information regarding a point, we need to specify the side of that point, and the time lengths of the remaining segments ahead of that point. So point G can be described with \"LeftSide, [10, 25, 8]\", point F can be described with \"RightSide, [40, 20, 2, 10, 25, 8]\", and so on."
                    , plainPara "Since we have already figured out the base case of the problem, let's write down the base case for f:"
                    ]
                , ElmUI.textColumn
                    [ ElmUI.paddingXY 40 36
                    , ElmUI.spacingXY 0 30
                    , Font.size 24
                    ]
                    [ plainPara "f(LeftSide, [l, m, r]) = min(l, m + r)"
                    , plainPara "f(RightSide, [l, m, r]) = min(r, m + l)"
                    ]
                , ElmUI.textColumn
                    [ paraSpacing ]
                    [ plainPara "Let me explain: The base case is really the case where there are only 3 segments left. The segment on the left is denoted as l, the one in the middle as m, the one on the right as r. min(a, b) means \"the minimum between a and b\". From the previous quiz, if we are on LeftSide (like point G), the least time is the minimum between left segment l, versus the sum of the middle segment and the right segment. Similar reasoning for RightSide."
                    , plainPara "Now let's tackle the more general, recursive case. This will enable us to solve the problem at any point on the map. Let's start at LeftSide. I'm going to write the expression as:"
                    ]
                , ElmUI.paragraph
                    multiMathExpStyle
                    [ ElmUI.text "f(LeftSide, [l, m, r ||| rem])" ]
                , ElmUI.textColumn
                    [ paraSpacing ]
                    [ plainPara "Where l, m, r are the left, middle, right segments right in front of us. And all of the remaining segments further ahead of us, are abbreviated as rem."
                    , plainPara "What does it equal to?"
                    ]
                ]

        quiz4_RadioButtons qStatus =
            Input.radio
                quizRadioStyle
                { onChange =
                    \option ->
                        QuizRecvInput ( Part 4, 4 ) { sel = option, sub = qStatus.sub }
                , options =
                    [ Input.option (QuizSel 1) <|
                        ElmUI.textColumn
                            [ ElmUI.spacingXY 0 5 ]
                            [ plainPara "m + min("
                            , ElmUI.text "    l + f(LeftSide, rem),"
                            , plainPara ""
                            , ElmUI.text "    r + f(RightSide, rem),"
                            , plainPara ")"
                            ]
                    , Input.option (QuizSel 2) <|
                        ElmUI.textColumn
                            [ ElmUI.spacingXY 0 5 ]
                            [ plainPara "min("
                            , ElmUI.text "    l + f(LeftSide, rem),"
                            , plainPara ""
                            , ElmUI.text "    m + r + f(RightSide, rem)"
                            , plainPara ")"
                            ]
                    , Input.option (QuizSel 3) <| plainPara "min(l, m + r) + f(LeftSide, rem)"
                    , Input.option QuizPass <| plainPara "I'll pass."
                    ]
                , selected = Just qStatus.sel
                , label = Input.labelAbove [] <| ElmUI.none
                }

        quiz4_SubmitButton qStatus =
            mkQuizSubmitButton ( Part 4, 4 ) qStatus "Submit"

        quiz4_Resp qStatus =
            ElmUI.paragraph
                [ ElmUI.paddingXY 0 15
                , quizRespColor qStatus 2
                ]
                [ case qStatus.sub of
                    QuizSel 2 ->
                        ElmUI.text "That's correct!"

                    QuizSel 1 ->
                        ElmUI.text "This option is close, but it's not making sense. Since we are on LeftSide, adding m means going through the middle segment, and reaching RightSide. If the result of min is l + f(LeftSide, rem), it'd look like we are then teleporting back to LeftSide somehow."

                    QuizSel 3 ->
                        ElmUI.text "Not quite. This option doesn't make sense. If the result of min is m + r, it means we will be going through the middle segment, and then the right segment. But then f(LeftSide, rem) is added, which means we are teleporting back to LeftSide."

                    QuizPass ->
                        ElmUI.text "Don't worry. This sure is a tough one. With practice, recursive thinking will be a second nature."

                    _ ->
                        ElmUI.none
                ]

        quiz4 =
            ElmUI.column
                []
                [ quiz4_RadioButtons quizFourStatus
                , quiz4_SubmitButton quizFourStatus
                , quiz4_Resp quizFourStatus
                ]

        postQuiz4 =
            ElmUI.column
                []
                [ ElmUI.text "postQuiz4" ]
    in
    ElmUI.column
        []
        [ preQuiz1
        , quiz1
        , if quizOneStatus.sub == QuizSel 1 || quizOneStatus.sub == QuizPass then
            postQuiz1

          else
            ElmUI.none
        ]
