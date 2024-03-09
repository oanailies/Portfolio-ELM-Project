module Model.PersonalDetails exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, classList, id)
import Html.Attributes exposing (href)
import Html.Attributes exposing (target)


type alias DetailWithName =
    { name : String
    , detail : String
    }


type alias PersonalDetails =
    { name : String
    , contacts : List DetailWithName
    , intro : String
    , socials : List DetailWithName
    }

view : PersonalDetails -> Html msg
view details =
    let
        contactRow contact =
            div [ class "contact" ]
                [ div [ class "contact-name" ] [ text contact.name ]
                , div [ class "contact-detail" ] [ text contact.detail ]
                ]

        socialRow social =
            a [ class "social-link", href social.detail, target "_blank" ]  
                [ div [ class "social-name" ] [ text social.name ]
                , div [ class "social-detail" ] [ text social.detail ]
                ]
    in
    div []
        [ h1 [ id "name" ] [ text ("Buna, eu sunt " ++ details.name) ]
        , em [ id "intro" ] [ text ("Mai multe despre mine: " ++ details.intro) ]
        , p [] [ text "Ma poti contacta la:" ]
        , div [ id "contacts" ] (List.map contactRow details.contacts)
        , p [] [ text "Si ma mai poti gasi:" ]
        , div [ id "socials" ] (List.map socialRow details.socials)
        ]
