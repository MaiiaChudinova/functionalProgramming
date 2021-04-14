{-# LANGUAGE OverloadedStrings #-}

module Delete where

import           Database.MySQL.Base
import           Utils

class Delete a where
  deleteRow :: a -> [String] -> MySQLConn -> IO OK

instance Delete TableName where
  deleteRow Students params conn            = execute conn "DELETE FROM students WHERE id=?" [MySQLInt32 (toNum (head params))]
  deleteRow Groups params conn              = execute conn "DELETE FROM groups WHERE id=?" [MySQLInt32 (toNum (head params))]
  deleteRow Lecturers params conn           = execute conn "DELETE FROM lecturers WHERE id=?" [MySQLInt32 (toNum (head params))]
  deleteRow Themes params conn              = execute conn "DELETE FROM themes WHERE id=?" [MySQLInt32 (toNum (head params))]
  deleteRow Timetable params conn           = execute conn "DELETE FROM timetable WHERE id=?" [MySQLInt32 (toNum (head params))]
  deleteRow Qna params conn                 = execute conn "DELETE FROM qna WHERE id=?" [MySQLInt32 (toNum (head params))]
  deleteRow ThemeProgresses params conn =
    execute
      conn
      "DELETE FROM themeProgresses WHERE studentId=? and themeId=?"
      [MySQLInt32 (toNum (head params)), MySQLInt32 (toNum (params !! 1))]

deleteRowManager :: TableName -> MySQLConn -> IO ()
deleteRowManager tableName conn = do
  case tableName of
    Students -> do
      putStrLn "Enter student id: "
      field0 <- getLine
      deleteRow tableName [field0] conn
    Groups -> do
      putStrLn "Enter group id: "
      field0 <- getLine
      deleteRow tableName [field0] conn
    Lecturers -> do
      putStrLn "Enter lecturer id: "
      field0 <- getLine
      deleteRow tableName [field0] conn
    Themes -> do
      putStrLn "Enter theme id: "
      field0 <- getLine
      deleteRow tableName [field0] conn
    Timetable -> do
      putStrLn "Enter timetable (lesson) id: "
      field0 <- getLine
      deleteRow tableName [field0] conn
    Qna -> do
      putStrLn "Enter qna id: "
      field0 <- getLine
      deleteRow tableName [field0] conn
    ThemeProgresses -> do
      putStrLn "Enter student id: "
      field0 <- getLine
      putStrLn "Enter theme id: "
      field1 <- getLine
      deleteRow tableName [field0, field1] conn
  putStrLn "Row(s) deleted"
