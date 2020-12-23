module Main exposing (..)

import Browser
import Dict exposing (Dict)
import Element as ElmUI
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import Http
import P0 exposing (p0)
import P1 exposing (p1)
import P2 exposing (p2)


main =
    Browser.element { init = init, update = update, view = view, subscriptions = \_ -> Sub.none }


type alias Model =
    { partNum : Int, text : String }


type Msg
    = NextPage
    | PrevPage
    | GotExplainer (Result Http.Error String)
    | HomePage
    | CreditsPage


type alias AttributeList msg =
    List (ElmUI.Attribute msg)


maxPage =
    5


maxWidthPx =
    768


disabledColor =
    ElmUI.rgb255 128 128 128


explainerIndex : Dict Int (ElmUI.Element msg)
explainerIndex =
    Dict.fromList
        [ ( 0, p0 )
        , ( 1, p1 )
        , ( 2, p2 )
        ]


errPara : String -> ElmUI.Element m
errPara errMsg =
    ElmUI.paragraph []
        [ ElmUI.text <|
            "Error: I made a mistake when making this website. I was about to blame javascript but I remembered I'm using Elm.. Can you contact me about this? "
                ++ "ErrMsg: \""
                ++ errMsg
                ++ "\""
        ]


getExplainer : Int -> Cmd Msg
getExplainer p =
    Http.get
        { url = "/explainer?p=" ++ String.fromInt p
        , expect = Http.expectString GotExplainer
        }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model 0 "", getExplainer 0 )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NextPage ->
            ( Model (model.partNum + 1) model.text, getExplainer <| model.partNum + 1 )

        PrevPage ->
            ( Model (model.partNum - 1) model.text, getExplainer <| model.partNum - 1 )

        GotExplainer result ->
            case result of
                Ok newText ->
                    ( Model model.partNum newText, Cmd.none )

                Err _ ->
                    ( Model model.partNum "Error: Failed to fetch explainer text?", Cmd.none )

        HomePage ->
            ( Model 0 "", Cmd.none )

        CreditsPage ->
            ( Model 0 "", Cmd.none )


view : Model -> Html Msg
view model =
    ElmUI.layout [] <|
        let
            banner =
                ElmUI.textColumn
                    [ ElmUI.centerX
                    , ElmUI.padding 60
                    , ElmUI.spacingXY 0 40
                    , Font.family
                        [ Font.typeface "Z003"
                        , Font.serif
                        ]
                    ]
                    [ ElmUI.el
                        [ Font.center
                        , Font.size 72
                        ]
                        (ElmUI.text "Recursive")
                    , ElmUI.el
                        [ Font.center
                        , Font.size 64
                        ]
                        (ElmUI.text "Thinking")
                    ]

            navBar =
                let
                    navBarButton msg str =
                        Input.button
                            [ Font.size 24
                            , ElmUI.padding 8
                            , Border.width 2
                            , Border.rounded 6
                            ]
                            { onPress = Just msg
                            , label = ElmUI.text str
                            }
                in
                ElmUI.row
                    [ ElmUI.centerX
                    , ElmUI.paddingEach
                        { left = 0, right = 0, top = 10, bottom = 40 }
                    , ElmUI.spacingXY 40 0
                    ]
                    [ navBarButton HomePage "Home"
                    , navBarButton CreditsPage "Credits"
                    ]

            explainer =
                ElmUI.el
                    [ ElmUI.height <| ElmUI.maximum 550 <| ElmUI.px 550
                    , ElmUI.scrollbarY
                    ]
                <|
                    case Dict.get model.partNum explainerIndex of
                        Just e ->
                            e

                        Nothing ->
                            errPara "p exceeds boundary of explainerIndex."

            pageNavButtons =
                let
                    pageNavButtonStyle =
                        [ ElmUI.padding 5
                        , Border.width 2
                        , Border.rounded 6
                        ]

                    pageNavButtonStyle_Disabled =
                        pageNavButtonStyle ++ [ Border.color disabledColor ]
                in
                ElmUI.row
                    [ ElmUI.centerX
                    , ElmUI.padding 20
                    , ElmUI.spacingXY 30 0
                    ]
                    [ if model.partNum > 0 then
                        Input.button pageNavButtonStyle { onPress = Just PrevPage, label = ElmUI.text "Prev Page" }

                      else
                        Input.button pageNavButtonStyle_Disabled
                            { onPress = Nothing
                            , label = ElmUI.el [ Font.color disabledColor ] <| ElmUI.text "Prev Page"
                            }
                    , ElmUI.text <| String.fromInt model.partNum
                    , if model.partNum < maxPage then
                        Input.button pageNavButtonStyle { onPress = Just NextPage, label = ElmUI.text "Next Page" }

                      else
                        Input.button pageNavButtonStyle_Disabled
                            { onPress = Nothing
                            , label = ElmUI.el [ Font.color disabledColor ] <| ElmUI.text "Next Page"
                            }
                    ]
        in
        ElmUI.column
            [ ElmUI.centerX
            , ElmUI.width <| ElmUI.maximum maxWidthPx <| ElmUI.fill
            ]
            [ banner
            , navBar
            , explainer
            , pageNavButtons
            ]
