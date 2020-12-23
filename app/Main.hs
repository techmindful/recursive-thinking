{-# LANGUAGE OverloadedStrings #-}

import Network.Wai
import Network.HTTP.Types
import Network.Wai.Handler.Warp (run)

import qualified Data.ByteString as ByteStr
import qualified Data.ByteString.Char8 as Char8
import qualified Data.ByteString.Lazy as LzByteStr
import qualified Data.Binary.Builder as BinBuilder
import Text.Read (readMaybe)

app :: Application
app request respond = respond $ case rawPathInfo request of
  "/" -> index
  "/explainer" -> explainer $ queryString request
  _ -> notFound

index :: Response
index = responseFile
  status200
  [("Content-Type", "text/html")]
  "index.html"
  Nothing

explainer :: [QueryItem] -> Response
explainer queryItems =
  let
    respBadQuery = responseLBS
      status400
      [("Content-Type", "text/plain")]
      "Bad query. It should be ?p=<int>"

    parseQuery [(key, Just val)] =
      let
        v = Char8.unpack val
        p = readMaybe v :: Maybe Int
      in
        if Char8.unpack key == "p" && p /= Nothing then  -- "p" is key name, p is actual val.
          responseFile
            status200
            [("Content-Type", "text/plain")]
            ("static/explainers/p" ++ v ++ ".txt")
            Nothing
        else
          respBadQuery
    parseQuery _ = respBadQuery
  in
    parseQuery queryItems
    

notFound :: Response
notFound = responseLBS
  status404
  [("Content-Type", "text/plain")]
  "404 - Not Found"

main :: IO ()
main = do
  putStrLn $ "http://localhost:8080/"
  run 8080 app

