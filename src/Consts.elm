module Consts exposing (..)

import Element as ElmUI
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Tuple
import Types exposing (..)


homeUrlStr =
    "/"


moreUrlStr =
    "/more"


explainerUrlStrHead =
    "/part/"


maxPage =
    7


maxWidthPx =
    768


pythonCode =
    "from enum import Enum\n\nclass Side(Enum):\n    LEFT = 1\n    RIGHT = 2\n\n\nclass Intersection:\n    def __init__(self, side, segments):\n        self.side = side\n        self.segments = segments\n\n\ndef f(intersection):\n\n    l = intersection.segments[0]\n    m = intersection.segments[1]\n    r = intersection.segments[2]\n\n    # Base case\n    if len(intersection.segments) == 3:\n        if intersection.side == Side.LEFT:\n            return min(l, m + r)\n        elif intersection.side == Side.RIGHT:\n            return min(r, m + l)\n\n    further_segments = intersection.segments[3:]\n\n    next_intersection_on_left = Intersection(side = Side.LEFT, segments = further_segments)\n    next_intersection_on_right = Intersection(side = Side.RIGHT, segments = further_segments)\n\n    if intersection.side == Side.LEFT:\n\n        best_path_going_left = l + f(next_intersection_on_left)\n        best_path_going_right = m + r + f(next_intersection_on_right)\n\n        return min(best_path_going_left, best_path_going_right)\n\n    elif intersection.side == Side.RIGHT:\n\n        best_path_going_left = m + l + f(next_intersection_on_left)\n        best_path_going_right = r + f(next_intersection_on_right)\n\n        return min(best_path_going_left, best_path_going_right)\n    \n\nintersection_A = Intersection(\n    side = Side.LEFT,\n    segments = [50, 0, 10, 5, 30, 90, 40, 20, 2, 10, 25, 8]\n)\n\nleast_time_needed = f(intersection_A)\n\nprint(least_time_needed)\n"


haskellCode =
    "module Main  where\n\n\ndata Side = LEFT | RIGHT\n\n\nf :: Side -> [Int] -> Int\nf LEFT  (l : m : r : []) = min l (m + r)\nf RIGHT (l : m : r : []) = min r (m + l)\nf LEFT  (l : m : r : xs) = min (l + f LEFT xs) (m + r + f RIGHT xs)\nf RIGHT (l : m : r : xs) = min (r + f RIGHT xs) (m + l + f LEFT xs)\n\nmain :: IO ()\nmain =\n  putStrLn $ show $ f LEFT [50, 0, 10, 5, 30, 90, 40, 20, 2, 10, 25, 8]"


plainPara : String -> ElmUI.Element Msg
plainPara str =
    ElmUI.paragraph
        []
        [ ElmUI.text str ]


{-| Apply this spacing in Element.paragraph for line spacing.

    Element.paragraph [ defaultLineSpacing, ... ] [ ... ]

-}
lineSpacing : ElmUI.Attribute Msg
lineSpacing =
    ElmUI.spacingXY 0 24


paraSpacing : ElmUI.Attribute Msg
paraSpacing =
    ElmUI.spacingXY 0 15


mathExpStyle : List (ElmUI.Attribute Msg)
mathExpStyle =
    [ Font.center
    , ElmUI.paddingXY 0 36
    , Font.size 24
    ]


multiMathExpStyle : List (ElmUI.Attribute Msg)
multiMathExpStyle =
    [ ElmUI.paddingXY 40 36
    , ElmUI.spacingXY 0 10
    , Font.size 24
    ]


disabledColor =
    ElmUI.rgb255 128 128 128


externalLink urlStr labelStr =
    ElmUI.newTabLink
        [ Font.color <| ElmUI.rgb255 0 0 255
        , Font.underline
        ]
        { url = urlStr
        , label = ElmUI.text labelStr
        }


errPara : String -> ElmUI.Element m
errPara errMsg =
    ElmUI.paragraph []
        [ ElmUI.text <|
            "Error: I made a mistake when making this website. I was about to blame javascript but I remembered I'm using Elm.. Can you contact me about this? "
                ++ "ErrMsg: \""
                ++ errMsg
                ++ "\""
        ]
