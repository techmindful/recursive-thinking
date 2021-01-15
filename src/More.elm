module More exposing (more)

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


more : ElmUI.Element Msg
more =
    ElmUI.column
        [ ElmUI.spacingXY 0 40 ]
        [ ElmUI.textColumn
            [ ElmUI.spacingXY 0 10 ]
            [ plainPara "The author of this website is: Me."
            , ElmUI.paragraph
                []
                [ ElmUI.text "The tool used to build this website is: "
                , externalLink
                    "https://elm-lang.org/"
                    "Elm"
                , ElmUI.text "."
                ]
            ]
        , ElmUI.textColumn
            []
            [ ElmUI.paragraph
                []
                [ ElmUI.text "Recursion is also a key concept in "
                , externalLink
                    "https://en.wikipedia.org/wiki/Functional_programming"
                    "functional programming"
                , ElmUI.text ". My favorite guide to functional programming with Haskell is "
                , externalLink
                    "http://learnyouahaskell.com/"
                    "Learn You a Haskell for Great Good"
                , ElmUI.text " (As much as I love it, it's non-https, so be very careful about security issues! Generally, don't make payments, input sensitive data, or trust any links on non-https websites.)"
                ]
            ]
        ]
