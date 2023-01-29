module Main where

type FormType = (Int, String)

main = do
    line <- getLine
    let form = read line :: FormType
    print form
    return form
