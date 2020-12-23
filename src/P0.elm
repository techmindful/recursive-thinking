module P0 exposing (p0)

import Element as ElmUI
import Html


p0 : ElmUI.Element msg
p0 =
    ElmUI.textColumn
        [ ElmUI.spacingXY 0 15 ]
        [ ElmUI.paragraph []
            [ ElmUI.text
                "Hi there, welcome! Here on this website, I'm going to show you the concept of recursive thinking, a.k.a. recursion."
            ]
        , ElmUI.paragraph []
            [ ElmUI.text "Many people are entertained by the idea of recursion, because it's a meta and funky concept. Most are also often confused, because it seems to be mind-twisting by nature. I find recursion to be not only useful, but more importantly also a new perspective of problem-solving. A new way of thinking."
            ]
        , ElmUI.paragraph []
            [ ElmUI.text "So let's dive into it!" ]
        ]
