module Model.Repo exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Json.Decode as De


type alias Repo =
    { name : String
    , description : Maybe String
    , url : String
    , pushedAt : String
    , stars : Int
    }


view : Repo -> Html msg
view repo =
    div [ class "repo" ]
        [ h2 [ class "repo-name" ] [ text repo.name ]
        , p [] [ text (Maybe.withDefault "" repo.description) ]
        , p [ class "repo-url" ] [ text ("URL: "), a [ href repo.url ] [ text repo.url ] ]
        , p [ class "repo-push" ] [ text ("Pushed at: " ++ repo.pushedAt) ]
        , p [ class "repo-stars" ] [ text ("Stars: " ++ String.fromInt repo.stars) ]
        ]



sortByStars : List Repo -> List Repo
sortByStars repos =
    List.sortBy (\repo -> repo.stars) repos




{-| Deserializes a JSON object to a `Repo`.
Field mapping (JSON -> Elm):

  - name -> name
  - description -> description
  - html\_url -> url
  - pushed\_at -> pushedAt
  - stargazers\_count -> stars

-}
decodeRepo : De.Decoder Repo
decodeRepo =
    De.map5 Repo
        (De.field "name" De.string)
        (De.field "description" (De.maybe De.string))
        (De.field "html_url" De.string)
        (De.field "pushed_at" De.string)
        (De.field "stargazers_count" De.int)
