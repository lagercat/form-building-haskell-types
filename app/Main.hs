{-# LANGUAGE DeriveGeneric #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use when" #-}
{-# HLINT ignore "Use maybe" #-}

module Main where

import GHC.Generics
import Data.ByteString.Lazy.Char8
import Data.Aeson
import Data.Maybe

-- Define generic Field type for any field in a form
data Field a = Field {
    label :: String,
    regex :: String,
    value :: a
} deriving (Show, Read, Generic)

instance ToJSON a => ToJSON (Field a) where
    toEncoding = genericToEncoding defaultOptions

instance FromJSON a => FromJSON (Field a)

-- Define a specific form
data Person = Person {
    name :: Field String,
    age  :: Field Int 
} deriving (Generic, Show)

instance ToJSON Person where
    toEncoding = genericToEncoding defaultOptions

instance FromJSON Person

main = do
    content <- Data.ByteString.Lazy.Char8.readFile "Person.JSON"
    let decoded = decode content :: Maybe Person
    if isJust decoded
        then print (fromJust decoded)
        else print "Error"
    return ()
