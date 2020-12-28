module Main exposing (..)

import AssocList
import Browser
import Browser.Navigation as Nav
import Consts exposing (..)
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
import Types exposing (..)
import Url exposing (Url)
import Url.Builder
import Url.Parser exposing ((</>))


type alias UrlParser a b =
    Url.Parser.Parser a b


main =
    Browser.application
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        , onUrlRequest = UserClickedLink
        , onUrlChange = UrlHasChanged
        }


routeParser : UrlParser (Route -> a) a
routeParser =
    Url.Parser.oneOf
        [ Url.Parser.map Home Url.Parser.top
        , Url.Parser.map Part (Url.Parser.s "part" </> Url.Parser.int)
        , Url.Parser.map More (Url.Parser.s "more")
        ]


getRoute : Url -> Route
getRoute url =
    Maybe.withDefault NotFound <| Url.Parser.parse routeParser url


explainerIndex : Model -> Dict Int (ElmUI.Element Msg)
explainerIndex model =
    Dict.fromList
        [ ( 1, p1 model )
        , ( 2, p2 model )
        ]


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init () url navKey =
    ( { route = getRoute url
      , navKey = navKey
      , quizStatuses = AssocList.empty
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UserClickedLink req ->
            case req of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.navKey <| Url.toString url )

                Browser.External url ->
                    ( model, Nav.load url )

        UrlHasChanged url ->
            ( { model | route = getRoute url }, Cmd.none )

        QuizRecvInput quizID quizStatus ->
            ( { model
                | quizStatuses =
                    AssocList.update quizID (\_ -> Just quizStatus) model.quizStatuses
              }
            , Cmd.none
            )

        QuizErr ->
            ( model, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    { title = "Recursive Thinking"
    , body =
        [ ElmUI.layout [] <|
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
                        navBarButton urlStr labelStr =
                            ElmUI.link
                                [ ElmUI.centerX
                                , ElmUI.padding 8
                                , Font.size 24
                                , Border.width 2
                                , Border.rounded 6
                                ]
                                { url = urlStr
                                , label = ElmUI.text labelStr
                                }
                    in
                    ElmUI.row
                        [ ElmUI.centerX
                        , ElmUI.paddingEach
                            { left = 0, right = 0, top = 10, bottom = 40 }
                        , ElmUI.spacingXY 40 0
                        ]
                        [ navBarButton homeUrlStr "Home"
                        , navBarButton moreUrlStr "More"
                        ]

                currentPartNum =
                    case model.route of
                        Part p ->
                            p

                        _ ->
                            -1

                explainer =
                    ElmUI.el
                        [ ElmUI.centerX

                        -- This padding prevents the left side of the highlighted border of
                        -- Page nav buttons to be half-clipped when clicked.
                        -- But it also causes explainer to be 20px bigger than max width.
                        , ElmUI.padding 10
                        ]
                    <|
                        case Dict.get currentPartNum <| explainerIndex model of
                            Just e ->
                                e

                            Nothing ->
                                errPara "p exceeds boundary of explainerIndex."
            in
            ElmUI.column
                -- Constrain everything in middle.
                [ ElmUI.centerX
                , ElmUI.width <| ElmUI.maximum maxWidthPx <| ElmUI.fill
                ]
            <|
                [ banner
                , navBar
                ]
                    ++ (case model.route of
                            Home ->
                                [ p0 ]

                            Part p ->
                                [ explainer ]

                            More ->
                                [ ElmUI.paragraph [ lineSpacing ] [ ElmUI.text "MoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMoreMore" ] ]

                            _ ->
                                [ ElmUI.text "Route error" ]
                       )
        ]
    }
