module Main exposing (..)

import AssocList
import Browser
import Browser.Dom as Dom
import Browser.Navigation as Nav
import Consts exposing (..)
import Dict exposing (Dict)
import Element as ElmUI
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import Http
import List.Extra as List
import More exposing (more)
import P0 exposing (p0)
import P1 exposing (p1)
import P2 exposing (p2)
import P3 exposing (p3)
import P4 exposing (p4)
import P5 exposing (..)
import P6 exposing (p6)
import P7 exposing (p7)
import Svg
import Svg.Attributes as SvgAttr
import Task
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
        , ( 3, p3 model )
        , ( 4, p4 model )
        , ( 5, p5 model )
        , ( 6, p6 model )
        , ( 7, p7 model )
        ]


init : () -> Url -> Nav.Key -> ( Model, Cmd Msg )
init () url navKey =
    let
        allPartRoutes =
            List.map Part <| List.range 1 maxPage

        allQuizIDs =
            List.lift2 Tuple.pair allPartRoutes <| List.range 1 10

        allQuizStatuses =
            List.lift2 Tuple.pair allQuizIDs <| List.singleton { sel = QuizNoInput, sub = QuizNoInput }
    in
    ( { route = getRoute url
      , navKey = navKey
      , quizStatuses = AssocList.fromList allQuizStatuses
      , domIdElements = AssocList.empty
      , demoCodeLang = Python
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
            let
                resetViewportCmd =
                    Task.perform (\_ -> Ignore) (Dom.setViewport 0 0)

                getPartFiveDomElementCmd : String -> Cmd Msg
                getPartFiveDomElementCmd id =
                    Task.attempt (GotPartFiveDomElement id) (Dom.getElement id)

                route =
                    getRoute url

                cmds =
                    -- If user navigates to Part 5, get its DOM element positions.
                    case route of
                        Part 5 ->
                            Cmd.batch
                                [ resetViewportCmd
                                , getPartFiveDomElementCmd id_q_cd
                                , getPartFiveDomElementCmd id_q_ef
                                ]

                        _ ->
                            resetViewportCmd
            in
            ( { model | route = getRoute url }
            , cmds
            )

        QuizRecvInput quizID quizStatus ->
            ( { model
                | quizStatuses =
                    AssocList.update quizID (\_ -> Just quizStatus) model.quizStatuses
              }
            , Cmd.none
            )

        QuizErr ->
            ( model, Cmd.none )

        GotPartFiveDomElement id result ->
            case result of
                Err _ ->
                    ( model, Cmd.none )

                Ok domElement ->
                    ( { model
                        | domIdElements =
                            AssocList.insert id domElement model.domIdElements
                      }
                    , Cmd.none
                    )

        SelectDemoCodeLang lang ->
            ( { model | demoCodeLang = lang }, Cmd.none )

        Ignore ->
            ( model, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    { title = "Recursive Thinking"
    , body =
        [ -- Part 5 SVG.
          ElmUI.layout
            (case model.route of
                Part 5 ->
                    [ ElmUI.behindContent <| partFiveSvg model ]

                _ ->
                    []
            )
          <|
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
                                [ more ]

                            _ ->
                                [ ElmUI.text "Route error" ]
                       )
        ]
    }


partFiveSvg : Model -> ElmUI.Element Msg
partFiveSvg model =
    let
        domElementToPos : Dom.Element -> ( Float, Float )
        domElementToPos domElement =
            ( domElement.element.x, domElement.element.y )

        maybe_q_ef_pos =
            Maybe.map domElementToPos <| AssocList.get id_q_ef model.domIdElements

        maybe_q_cd_pos =
            Maybe.map domElementToPos <| AssocList.get id_q_cd model.domIdElements
    in
    case Maybe.map2 (drawArrow -30) maybe_q_ef_pos maybe_q_cd_pos of
        Nothing ->
            ElmUI.text <| Debug.toString model.domIdElements

        Just e ->
            e


drawArrow : Float -> ( Float, Float ) -> ( Float, Float ) -> ElmUI.Element Msg
drawArrow xOffset ( startX, startY ) ( endX, endY ) =
    let
        rightArrowHeadId =
            "rightArrowHead"

        leftArrowHeadId =
            "leftArrowHead"

        arrowHeadAttrs id =
            [ SvgAttr.id id
            , SvgAttr.refX "5"
            , SvgAttr.refY "5"
            , SvgAttr.viewBox "0 0 10 10"
            , SvgAttr.markerWidth "6"
            , SvgAttr.markerHeight "6"
            ]

        rightArrowHead =
            Svg.marker
                (arrowHeadAttrs rightArrowHeadId)
                [ Svg.path
                    [ SvgAttr.d "M 0 0 L 10 5 L 0 10 Z" ]
                    []
                ]

        leftArrowHead =
            Svg.marker
                (arrowHeadAttrs leftArrowHeadId)
                [ Svg.path
                    [ SvgAttr.d "M 10 0 L 0 5 L 10 10 Z" ]
                    []
                ]
    in
    ElmUI.html <|
        Svg.svg
            [ SvgAttr.width "100%"
            , SvgAttr.height "100%"
            ]
            [ Svg.defs
                []
                [ rightArrowHead
                , leftArrowHead
                ]
            , Svg.path
                [ SvgAttr.d <|
                    "M "
                        ++ String.fromFloat startX
                        ++ " "
                        ++ String.fromFloat startY
                        ++ "h "
                        ++ String.fromFloat xOffset
                        ++ "V "
                        ++ String.fromFloat endY
                        ++ "h "
                        ++ String.fromFloat -xOffset
                , SvgAttr.stroke "black"
                , SvgAttr.fill "white"
                , SvgAttr.markerEnd <| "url(#" ++ rightArrowHeadId ++ ")"
                ]
                []
            , Svg.circle
                [ SvgAttr.cx <| "950"
                , SvgAttr.cy <| "950"
                , SvgAttr.r "100"
                ]
                []
            ]
