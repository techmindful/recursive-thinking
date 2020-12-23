module P2 exposing (p2)

import Element as ElmUI
import Html


p2 : ElmUI.Element msg
p2 =
    ElmUI.textColumn
        [ ElmUI.spacingXY 0 15 ]
        [ ElmUI.paragraph []
            [ ElmUI.text
                "Third part of explainer."
            ]
        ]
