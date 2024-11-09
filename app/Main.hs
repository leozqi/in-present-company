module Main where

import qualified Brick.AttrMap      as A
import           Brick.BChan        (BChan, newBChan)
import qualified Brick.Focus        as F
import qualified Brick.Main         as M
import qualified Brick.Widgets.Edit as E
import           Control.Monad      (void, when)
import qualified Data.ByteString    as B
import qualified Data.Map.Strict    as Map
import           Data.Text          (Text)
import           Data.Text.Encoding (encodeUtf8)
import qualified Graphics.Vty       as V
import           System.Directory
    ( createDirectory
    , doesDirectoryExist
    , doesFileExist
    , getHomeDirectory
    )
import           System.Exit        (exitFailure)
import           System.FilePath    (takeFileName, (</>))

drawUI :: State -> [Widget Field]
drawUI st = case st ^. activeView of
  LoginView -> drawDialog  st
  -         -> drawBrowser st

theApp :: A.AttrMap -> M.App State Event Field
theApp theMap =
  M.App
  { M.appDraw = drawUI,
    M.appChooseCursor = M.showFirstCursor,
    M.appHandleEvent = appEvent,
    M.appStartEvent = pure,
    M.appAttrMap = const theMap
  }

ui :: Widget()
ui = str "Hello, world!"

main :: IO ()
main = simpleMain ui
