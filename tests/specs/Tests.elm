module Tests exposing (spec)

import JsonSchema exposing (..)
import Model exposing (Schema)
import Encoder exposing (encoder)
import Helpers exposing (expectAt, lengthAt)
import Json.Decode as Decode
import Test exposing (..)


spec : Test
spec =
    describe "JsonSchema"
        [ objectSchemaSpec
        , arraySchemaSpec
        , stringSchemaSpec
        , integerSchemaSpec
        , numberSchemaSpec
        , booleanSchemaSpec
        , nullSchemaSpec
        ]


objectSchema : Schema
objectSchema =
    object
        [ title "object schema title"
        , description "object schema description"
        , properties
            [ optional "firstName" <| string []
            , required "lastName" <| string []
            ]
        ]


objectSchemaSpec : Test
objectSchemaSpec =
    describe "object schema"
        [ test "title property is set" <|
            \() ->
                encoder objectSchema
                    |> expectAt
                        [ "title" ]
                        ( Decode.string, "object schema title" )
        , test "description property is set" <|
            \() ->
                encoder objectSchema
                    |> expectAt
                        [ "description" ]
                        ( Decode.string, "object schema description" )
        , test "has the right type" <|
            \() ->
                encoder objectSchema
                    |> expectAt
                        [ "type" ]
                        ( Decode.string, "object" )
        , test "adds the right properties to 'required'" <|
            \() ->
                encoder objectSchema
                    |> expectAt
                        [ "required", "0" ]
                        ( Decode.string, "lastName" )
        , test "array 'required' has correct length" <|
            \() ->
                encoder objectSchema
                    |> lengthAt [ "required" ] 1
        , test "first object property exists as nested schema" <|
            \() ->
                encoder objectSchema
                    |> expectAt
                        [ "properties", "firstName", "type" ]
                        ( Decode.string, "string" )
        , test "second object property exists as nested schema" <|
            \() ->
                encoder objectSchema
                    |> expectAt
                        [ "properties", "lastName", "type" ]
                        ( Decode.string, "string" )
        ]


arraySchema : Schema
arraySchema =
    array
        [ title "array schema title"
        , description "array schema description"
        , items <| string []
        ]


arraySchemaSpec : Test
arraySchemaSpec =
    describe "array schema"
        [ test "title property is set" <|
            \() ->
                encoder arraySchema
                    |> expectAt
                        [ "title" ]
                        ( Decode.string, "array schema title" )
        , test "description property is set" <|
            \() ->
                encoder arraySchema
                    |> expectAt
                        [ "description" ]
                        ( Decode.string, "array schema description" )
        , test "has the right type" <|
            \() ->
                encoder arraySchema
                    |> expectAt
                        [ "type" ]
                        ( Decode.string, "array" )
        , test "items property contains nested schema" <|
            \() ->
                encoder arraySchema
                    |> expectAt
                        [ "items", "type" ]
                        ( Decode.string, "string" )
        ]


stringSchema : Schema
stringSchema =
    string
        [ title "string schema title"
        , description "string schema description"
        , minLength 2
        , maxLength 8
        , pattern "^foo$"
        , format dateTime
        ]


stringSchemaSpec : Test
stringSchemaSpec =
    describe "string schema"
        [ test "title property is set" <|
            \() ->
                encoder stringSchema
                    |> expectAt
                        [ "title" ]
                        ( Decode.string, "string schema title" )
        , test "description property is set" <|
            \() ->
                encoder stringSchema
                    |> expectAt
                        [ "description" ]
                        ( Decode.string, "string schema description" )
        , test "has the right type" <|
            \() ->
                encoder stringSchema
                    |> expectAt
                        [ "type" ]
                        ( Decode.string, "string" )
        , test "minLength property is set" <|
            \() ->
                encoder stringSchema
                    |> expectAt
                        [ "minLength" ]
                        ( Decode.int, 2 )
        , test "maxLength property is set" <|
            \() ->
                encoder stringSchema
                    |> expectAt
                        [ "maxLength" ]
                        ( Decode.int, 8 )
        , test "pattern property is set" <|
            \() ->
                encoder stringSchema
                    |> expectAt
                        [ "pattern" ]
                        ( Decode.string, "^foo$" )
        , test "format property is set" <|
            \() ->
                encoder stringSchema
                    |> expectAt
                        [ "format" ]
                        ( Decode.string, "date-time" )
        ]


integerSchema : Schema
integerSchema =
    integer
        [ title "integer schema title"
        , description "integer schema description"
        , minimum 2
        , maximum 8
        ]


integerSchemaSpec : Test
integerSchemaSpec =
    describe "integer schema"
        [ test "title property is set" <|
            \() ->
                encoder integerSchema
                    |> expectAt
                        [ "title" ]
                        ( Decode.string, "integer schema title" )
        , test "description property is set" <|
            \() ->
                encoder integerSchema
                    |> expectAt
                        [ "description" ]
                        ( Decode.string, "integer schema description" )
        , test "has the right type" <|
            \() ->
                encoder integerSchema
                    |> expectAt
                        [ "type" ]
                        ( Decode.string, "integer" )
        , test "minimum property is set" <|
            \() ->
                encoder integerSchema
                    |> expectAt
                        [ "minimum" ]
                        ( Decode.int, 2 )
        , test "maximum property is set" <|
            \() ->
                encoder integerSchema
                    |> expectAt
                        [ "maximum" ]
                        ( Decode.int, 8 )
        ]


numberSchema : Schema
numberSchema =
    number
        [ title "number schema title"
        , description "number schema description"
        , minimum 2.5
        , maximum 8.3
        ]


numberSchemaSpec : Test
numberSchemaSpec =
    describe "number schema"
        [ test "title property is set" <|
            \() ->
                encoder numberSchema
                    |> expectAt
                        [ "title" ]
                        ( Decode.string, "number schema title" )
        , test "description property is set" <|
            \() ->
                encoder numberSchema
                    |> expectAt
                        [ "description" ]
                        ( Decode.string, "number schema description" )
        , test "has the right type" <|
            \() ->
                encoder numberSchema
                    |> expectAt
                        [ "type" ]
                        ( Decode.string, "number" )
        , test "minimum property is set" <|
            \() ->
                encoder numberSchema
                    |> expectAt
                        [ "minimum" ]
                        ( Decode.float, 2.5 )
        , test "maximum property is set" <|
            \() ->
                encoder numberSchema
                    |> expectAt
                        [ "maximum" ]
                        ( Decode.float, 8.3 )
        ]


booleanSchema : Schema
booleanSchema =
    boolean
        [ title "boolean schema title"
        , description "boolean schema description"
        ]


booleanSchemaSpec : Test
booleanSchemaSpec =
    describe "boolean schema"
        [ test "title property is set" <|
            \() ->
                encoder booleanSchema
                    |> expectAt
                        [ "title" ]
                        ( Decode.string, "boolean schema title" )
        , test "description property is set" <|
            \() ->
                encoder booleanSchema
                    |> expectAt
                        [ "description" ]
                        ( Decode.string, "boolean schema description" )
        , test "has the right type" <|
            \() ->
                encoder booleanSchema
                    |> expectAt
                        [ "type" ]
                        ( Decode.string, "boolean" )
        ]


nullSchema : Schema
nullSchema =
    null
        [ title "null schema title"
        , description "null schema description"
        ]


nullSchemaSpec : Test
nullSchemaSpec =
    describe "null schema"
        [ test "title property is set" <|
            \() ->
                encoder nullSchema
                    |> expectAt
                        [ "title" ]
                        ( Decode.string, "null schema title" )
        , test "description property is set" <|
            \() ->
                encoder nullSchema
                    |> expectAt
                        [ "description" ]
                        ( Decode.string, "null schema description" )
        , test "has the right type" <|
            \() ->
                encoder nullSchema
                    |> expectAt
                        [ "type" ]
                        ( Decode.string, "null" )
        ]