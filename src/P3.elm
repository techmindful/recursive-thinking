module P3 exposing (p3)

import Consts exposing (..)
import Element as ElmUI
import Element.Font as Font
import Element.Input as Input
import Html
import PageNavButtons exposing (..)
import Types exposing (..)


p3 : Model -> ElmUI.Element Msg
p3 model =
    let
        prevPageButton =
            ElmUI.el defaultPrevPageBtnStyle <| mkPrevPageButton model
    in
    ElmUI.column
        []
    <|
        [ prevPageButton
        , plainPara "Our definition will be complete if we simply add 1! = 1 into it:"
        , ElmUI.textColumn
            [ ElmUI.paddingXY 40 36
            , ElmUI.spacingXY 0 10
            , Font.size 24
            ]
            [ plainPara "1! = 1"
            , plainPara "n! = n * (n - 1)!"
            ]
        , plainPara "When asked \"what is the factorial of n\", we can keep answering that \"the factorial of n equals to n times the factorial of (n - 1), until we reach \"what is the factorial of 1\". At that point, we can just answer that \"the factorial of 1 equals to 1\". This enables us to answer all the previous questions, in reverse order. Let's look at the example of 4! again:"
        , ElmUI.textColumn
            [ ElmUI.paddingXY 40 20
            , ElmUI.spacingXY 0 10
            ]
            [ plainPara "4! = 4 * 3! . But what is 3! then?"
            , plainPara "3! = 3 * 2! . But what is 2! then?"
            , plainPara "2! = 2 * 1! . But what is 1! then?"
            , plainPara "1! = 1, by definition. Therefore,"
            , plainPara "2! = 2 * 1! = 2 * 1 = 2. Therefore,"
            , plainPara "3! = 3 * 2! = 3 * 2 = 6. Therefore,"
            , plainPara "4! = 4 * 3! = 4 * 6 = 24."
            ]
        , plainPara "In our recursive definition, 1! = 1 is called the \"base case\" (or \"edge condition\").* The base case is critical in any recursive definition. Recursion without a base case is just silliness. But typically, the base case is also the most trivial case. Therefore, when making a recursive definition, people usually try to nail down the base case first."
        , ElmUI.paragraph
            [ ElmUI.paddingEach { top = 20, bottom = 0, left = 0, right = 0 }
            , Font.size 16
            ]
            [ ElmUI.text "* "
            , ElmUI.el
                [ Font.underline ]
                (ElmUI.text "For advanced readers")
            , ElmUI.text
                ": More commonly, the base case of factorial is actually defined to be 0! = 1. This plays out nicely with other formulas, like the combinatorial formula. "
            , externalLink
                "https://math.stackexchange.com/questions/20969/prove-0-1-from-first-principles/20975#20975"
                "This StackExchange answer"
            , ElmUI.text
                " has a brief explanation. But since we are just learning factorial here, let's stick with our more intuitive definition, where 1! = 1."
            ]
        , ElmUI.el
            [ ElmUI.paddingXY 0 20 ]
          <|
            mkNextPageButton model
        ]
