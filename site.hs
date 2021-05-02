--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Data.Monoid (mappend)
import           Hakyll
import           Text.Pandoc
import           Text.Pandoc.Fltr.LaTeXFilter
import           Text.Pandoc.Filter.Utils
import           Data.Time (UTCTime, defaultTimeLocale, parseTimeM)
import           Data.List (intercalate)
import           System.FilePath (takeFileName)
import Data.Monoid (mappend)
import Hakyll

import Data.List (isPrefixOf, tails, findIndex, intercalate, sortBy)
import Data.Maybe (fromMaybe)
import Control.Applicative (Alternative (..))
import Control.Monad (forM_, zipWithM_, liftM)
import System.FilePath (takeFileName)

import Data.Time.Format (parseTimeM, defaultTimeLocale)
import Data.Time.Clock (UTCTime)

import Text.Blaze.Html.Renderer.String (renderHtml)
import Text.Blaze.Html ((!), preEscapedString, toHtml, toValue)
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A

import Data.Hashable (Hashable, hashWithSalt)
import qualified Data.HashMap.Strict as HM
--------------------------------------------------------------------------------
postsGlob :: Pattern
postsGlob = "posts/**.md"

main :: IO ()
main = hakyll $ do
    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match (fromList ["about.rst", "contact.markdown"]) $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

--    match "posts/*" $ do
--        route $ setExtension "html"

    tags <- buildTags postsGlob (fromCapture "tags/*.html")

    categories <- buildCategories postsGlob (fromCapture "categories/*.html")

    rulesForTags categories (\tag -> "Posts in category \"" ++ tag ++ "\"")

    rulesForTags tags (\tag -> "Posts tagged \"" ++ tag ++ "\"")

    match postsGlob $ do
        route $ setExtension "html"
        compile $ do
            let postContext = postCtxWithTags tags

            pandocCompiler
                >>= saveSnapshot "teaser"
                >>= loadAndApplyTemplate "templates/post.html"    postContext
                >>= saveSnapshot "content"
                >>= loadAndApplyTemplate "templates/default.html" postContext
                >>= relativizeUrls

    create ["archive.html"] $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            let archiveCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    constField "title" "Archives"            `mappend`
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
                >>= loadAndApplyTemplate "templates/default.html" archiveCtx
                >>= relativizeUrls

    match "index.html" $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            let indexCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    defaultContext

            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/default.html" indexCtx
                >>= relativizeUrls

    match "templates/*" $ compile templateBodyCompiler

--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" `mappend`
    defaultContext

-- | See the definitions for explanation of each option.
opts :: LaTeXFilterOptions
opts = def
  { baseFontSize = 16
  , cacheDir     = Just "_tex-cache"
  , tempDir      = Just "_tex-tmp"
  }

-- | Used as an argument of 'pandocCompilerWithTransformM'
myTransform :: Pandoc -> Compiler Pandoc
myTransform = unsafeCompiler . getFilterM (latexFilter opts)

--------------------------------------------------------------------------------
rulesForTags :: Tags -> (String -> String) -> Rules ()
rulesForTags tags titleForTag =
    tagsRules tags $ \tag pattern -> do
    let title = titleForTag tag -- "Posts tagged \"" ++ tag ++ "\""
    route idRoute
    compile $ do
        posts <- recentFirst =<< loadAll pattern
        let ctx = constField "title" title
                  `mappend` listField "posts" postCtx (return posts)
                  `mappend` defaultContext

        makeItem ""
            >>= loadAndApplyTemplate "templates/tag.html" ctx
            >>= loadAndApplyTemplate "templates/default.html" ctx
            >>= relativizeUrls

sortIdentifiersByDate :: [Identifier] -> [Identifier]
sortIdentifiersByDate identifiers =
    reverse $ sortBy byDate identifiers
      where
    byDate id1 id2 =
        let fn1 = takeFileName $ toFilePath id1
            fn2 = takeFileName $ toFilePath id2
            parseTime' fn = parseTimeM True defaultTimeLocale "%Y-%m-%d" $ intercalate "-" $ take 3 $ splitAll "-" fn
        in compare ((parseTime' fn1) :: Maybe UTCTime) ((parseTime' fn2) :: Maybe UTCTime)

postCtxWithTags :: Tags -> Context String
postCtxWithTags tags =
    tagsField "tags" tags `mappend` postCtx

instance Hashable Identifier where
    hashWithSalt salt = hashWithSalt salt . show
