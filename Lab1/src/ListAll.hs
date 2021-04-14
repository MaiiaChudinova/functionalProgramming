{-# LANGUAGE OverloadedStrings #-}

module ListAll where

import           Database.MySQL.Base
import qualified System.IO.Streams   as Streams
import           Utils

class ListAll a where
  listAll :: a -> MySQLConn -> IO ([ColumnDef], Streams.InputStream [MySQLValue])

instance ListAll TableName where
  listAll Students conn           = query_ conn "SELECT * FROM students"
  listAll Groups conn             = query_ conn "SELECT * FROM groups"
  listAll Lecturers conn          = query_ conn "SELECT * FROM lecturers"
  listAll Themes conn             = query_ conn "SELECT * FROM themes"
  listAll ThemeProgresses conn    = query_ conn "SELECT * FROM themeProgresses"
  listAll Qna conn                = query_ conn "SELECT * FROM qna"
  listAll Timetable conn          = query_ conn "SELECT * FROM timetable"

listAllManager :: TableName -> MySQLConn -> IO ()
listAllManager tableName conn = do
  (defs, is) <- listAll tableName conn
  print ("id" : tableColumns tableName)
  mapM_ print =<< Streams.toList is
