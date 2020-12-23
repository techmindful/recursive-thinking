module Main exposing (..)

import Browser
import Html exposing (Html)
import Element as ElmUI
import Element.Font as Font
import Element.Input as Input
import Element.Border as Border

main = Browser.sandbox { init = init, update = update, view = view }

type alias Model = Int

type Msg
  = NextPage
  | PrevPage

type alias AttributeList msg = List (ElmUI.Attribute msg)

maxPage = 5
maxWidthPx = 768

disabledColor = ElmUI.rgb255 128 128 128

init : Model
init = 0

update : Msg -> Model -> Model
update msg model =
  case msg of
    NextPage -> model + 1
    PrevPage -> model - 1

view : Model -> Html Msg
view model =
  ElmUI.layout []
  <|
    (let
      banner = ElmUI.textColumn
        [
          ElmUI.centerX,
          ElmUI.padding 60,
          ElmUI.spacingXY 0 40,

          Font.family
          [
            Font.typeface "Z003",
            Font.serif
          ]
        ]
        [
          ElmUI.el
          [
            Font.center,
            Font.size 72
          ]
          (ElmUI.text "Recursive"),

          ElmUI.el
          [
            Font.center,
            Font.size 64
          ]
          (ElmUI.text "Thinking")
        ]

      navBar = ElmUI.none

      explainer = ElmUI.none

      pageNavButtons =
        let
          pageNavButtonStyle =
            [
              ElmUI.padding 5,
              Border.width 2,
              Border.rounded 6
            ]

          pageNavButtonStyle_Disabled = pageNavButtonStyle ++ [ Border.color disabledColor ]
        in
          ElmUI.row
          [
            ElmUI.centerX,
            ElmUI.spacingXY 30 0
          ]
          [
            (if model > 0 then
              Input.button pageNavButtonStyle { onPress = Just PrevPage, label = ElmUI.text "Prev Page" }
            else
              Input.button pageNavButtonStyle_Disabled
              {
                onPress = Nothing,
                label = ElmUI.el [ Font.color disabledColor ] <| ElmUI.text "Prev Page"
              }),

            ElmUI.text <| String.fromInt model,

            (if model < maxPage then
              Input.button pageNavButtonStyle { onPress = Just NextPage, label = ElmUI.text "Next Page" }
            else
              Input.button pageNavButtonStyle_Disabled
              {
                onPress = Nothing,
                label = ElmUI.el [ Font.color disabledColor ] <| ElmUI.text "Next Page"
              }
            )
          ]
    in
      ElmUI.column
      [
        ElmUI.centerX,
        ElmUI.width <| ElmUI.maximum maxWidthPx <| ElmUI.fill
      ]
      [
        banner,
        navBar,
        explainer,
        pageNavButtons
      ]
    )

