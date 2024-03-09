module Model.Event.Category exposing (EventCategory(..), SelectedEventCategories, allSelected, eventCategories, isEventCategorySelected, set, view)

import Html exposing (Html, div, input, text)
import Html.Attributes exposing (checked, class, style, type_)
import Html.Events exposing (onCheck)


type EventCategory
    = Academic
    | Work
    | Project
    | Award


eventCategories =
    [ Academic, Work, Project, Award ]


{-| Type used to represent the state of the selected event categories
-}
type SelectedEventCategories
    = SelectedEventCategories Bool Bool Bool Bool


{-| Returns an instance of `SelectedEventCategories` with all categories selected

    isEventCategorySelected Academic allSelected --> True

-}
allSelected : SelectedEventCategories
allSelected =
     SelectedEventCategories True True True True
    --Debug.todo "Implement Model.Event.Category.allSelected"

{-| Returns an instance of `SelectedEventCategories` with no categories selected

-- isEventCategorySelected Academic noneSelected --> False

-}
noneSelected : SelectedEventCategories
noneSelected =
     SelectedEventCategories False False False False
    --Debug.todo "Implement Model.Event.Category.noneSelected"

{-| Given a the current state and a `category` it returns whether the `category` is selected.

    isEventCategorySelected Academic allSelected --> True

-}
isEventCategorySelected : EventCategory -> SelectedEventCategories -> Bool
isEventCategorySelected category selectedCategories =
    case (category, selectedCategories) of
        (Academic, SelectedEventCategories ac _ _ _) -> ac
        (Work, SelectedEventCategories _ w _ _) -> w
        (Project, SelectedEventCategories _ _ proj _) -> proj
        (Award, SelectedEventCategories _ _ _ aw) -> aw

    --Debug.todo "Implement Model.Event.Category.isEventCategorySelected"


{-| Given an `category`, a boolean `value` and the current state, it sets the given `category` in `current` to `value`.

    allSelected |> set Academic False |> isEventCategorySelected Academic --> False

    allSelected |> set Academic False |> isEventCategorySelected Work --> True

-}
set : EventCategory -> Bool -> SelectedEventCategories -> SelectedEventCategories
set category value current =
    case category of
        Academic ->
            SelectedEventCategories value (isEventCategorySelected Work current) (isEventCategorySelected Project current) (isEventCategorySelected Award current)

        Work ->
            SelectedEventCategories (isEventCategorySelected Academic current) value (isEventCategorySelected Project current) (isEventCategorySelected Award current)

        Project ->
            SelectedEventCategories (isEventCategorySelected Academic current) (isEventCategorySelected Work current) value (isEventCategorySelected Award current)

        Award ->
            SelectedEventCategories (isEventCategorySelected Academic current) (isEventCategorySelected Work current) (isEventCategorySelected Project current) value




checkbox : String -> Bool -> EventCategory -> Html ( EventCategory, Bool )
checkbox name state category =
    div [ style "display" "inline", class "category-checkbox" ]
        [ input [ type_ "checkbox", onCheck (\c -> ( category, c )), checked state ] []
        , text name
        ]

view : SelectedEventCategories -> Html (EventCategory, Bool)
view model =
    div []
        [ checkbox "Academic" (isEventCategorySelected Academic model) Academic
        , checkbox "Work" (isEventCategorySelected Work model) Work
        , checkbox "Project" (isEventCategorySelected Project model) Project
        , checkbox "Award" (isEventCategorySelected Award model) Award
        ]
