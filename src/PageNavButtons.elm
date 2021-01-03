module PageNavButtons exposing
    ( defaultNextPageBtnStyle
    , defaultPrevPageBtnStyle
    , mkNextPageButton
    , mkPrevPageButton
    )

import Consts exposing (..)
import Element as ElmUI
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Types exposing (..)


getPartNum : Model -> Maybe Int
getPartNum model =
    case model.route of
        Part p ->
            Just p

        _ ->
            Nothing


style =
    [ ElmUI.padding 5
    , Border.width 2
    , Border.rounded 6
    ]


style_Disabled =
    style ++ [ Border.color disabledColor ]


illPlacedButton : ElmUI.Element Msg
illPlacedButton =
    Input.button
        style_Disabled
        { onPress = Nothing
        , label =
            ElmUI.el
                [ Font.color <| ElmUI.rgba 255 0 0 128 ]
            <|
                ElmUI.text "Error: An ill-placed button 😦"
        }


linkToPart : Int -> String -> ElmUI.Element Msg
linkToPart n labelStr =
    ElmUI.link
        style
        { url = explainerUrlStrHead ++ String.fromInt n
        , label = ElmUI.text labelStr
        }


disabledButton : String -> ElmUI.Element Msg
disabledButton labelStr =
    Input.button
        style_Disabled
        { onPress = Nothing
        , label = ElmUI.el [ Font.color disabledColor ] <| ElmUI.text labelStr
        }


mkPrevPageButton : Model -> ElmUI.Element Msg
mkPrevPageButton model =
    let
        partNum =
            getPartNum model
    in
    case partNum of
        Just n ->
            if n > 1 then
                linkToPart (n - 1) "Previous Page"

            else
                disabledButton "Previous Page"

        Nothing ->
            illPlacedButton


mkNextPageButton model =
    let
        partNum =
            getPartNum model
    in
    case partNum of
        Just n ->
            if n < maxPage then
                linkToPart (n + 1) "Next Page"

            else
                disabledButton "Next Page"

        Nothing ->
            illPlacedButton


defaultPrevPageBtnStyle : List (ElmUI.Attribute Msg)
defaultPrevPageBtnStyle =
    [ ElmUI.paddingXY 0 20 ]


defaultNextPageBtnStyle =
    defaultPrevPageBtnStyle
