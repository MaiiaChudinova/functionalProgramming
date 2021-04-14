{-# LANGUAGE OverloadedStrings #-}

module FindById where

import           Database.MySQL.Base
import qualified System.IO.Streams   as Streams
import           Utils

class FindById a where
  findById :: a -> String -> MySQLConn -> IO ([ColumnDef], Streams.InputStream [MySQLValue])

instance FindById TableName where
  findById Students index conn               = query conn "SELECT * FROM students WHERE id=?" [MySQLInt32 (toNum index)]
  findById Groups index conn                 = query conn "SELECT * FROM groups WHERE id=?" [MySQLInt32 (toNum index)]
  findById Lecturers index conn              = query conn "SELECT * FROM lecturers WHERE id=?" [MySQLInt32 (toNum index)]
  findById Themes index conn                 = query conn "SELECT * FROM themes WHERE id=?" [MySQLInt32 (toNum index)]
  findById ThemeProgresses index conn        = query conn "SELECT * FROM themeProgresses WHERE studentId=?" [MySQLInt32 (toNum index)]
  findById Timetable index conn              = query conn "SELECT * FROM timetable WHERE id=?" [MySQLInt32 (toNum index)]
  findById Qna index conn =
    query conn "SELECT * FROM qna WHERE id=?" [MySQLInt32 (toNum index)]

findByManager :: TableName -> MySQLConn -> IO ()
findByManager tableName conn = do
  putStrLn "Enter id: "
  index <- getLine
  (defs, is) <- findById tableName index conn
  print ("id" : tableColumns tableName)
  print =<< Streams.toList is
