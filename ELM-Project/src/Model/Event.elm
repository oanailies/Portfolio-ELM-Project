module Model.Event exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, classList)
import Model.Event.Category exposing (EventCategory(..))
import Model.Interval as Interval exposing (Interval)
import Html.Attributes exposing (href)
import Debug exposing (toString)
import Model.Util exposing (chainCompare)


type alias Event =
    { title : String
    , interval : Interval
    , description : Html Never
    , category : EventCategory
    , url : Maybe String
    , tags : List String
    , important : Bool
    }


categoryView : EventCategory -> Html Never
categoryView category =
    case category of
        Academic ->
            text "Academic"

        Work ->
            text "Work"

        Project ->
            text "Project"

        Award ->
            text "Award"


sortByInterval : List Event -> List Event
sortByInterval events =
    List.sortWith (compareEventsByInterval) events

compareEventsByInterval : Event -> Event -> Order
compareEventsByInterval eventA eventB =
    Interval.compare eventA.interval eventB.interval


view : Event -> Html Never
view event =
    let
        eventClass =
            if event.important then
                "event event-important"
            else
                "event"

        titleClass =
            "event-title"

        descriptionClass =
            "event-description"

        categoryClass =
            "event-category"

        urlClass =
            "event-url"

        intervalClass =
            "event-interval"  

        eventAttributes =
            [ class eventClass ]

        titleAttributes =
            [ class titleClass ]

        descriptionAttributes =
            [ class descriptionClass ]

        categoryAttributes =
            [ class categoryClass ]

        urlAttributes =
            [ class urlClass ]

        intervalAttributes =
            [ class intervalClass ]  
    in
    div eventAttributes
        [ h2 titleAttributes [ text event.title ]
        , p descriptionAttributes [ text "Detalii suplimentare" , event.description ]
        , p categoryAttributes [ text "Categorie: ", categoryView event.category ]
        , case event.url of
            Just url ->
                p urlAttributes [ text "Detalii: ", a [ href url ] [ text "Apasa pentru detalii" ] ]

            Nothing ->
                text ""
        , p intervalAttributes [ text ("Interval: " ++ toString event.interval ++ " zile") ] 
        , p [] [ text ("Tags: " ++ String.join ", " event.tags ++ " etc.") ]
        ]
