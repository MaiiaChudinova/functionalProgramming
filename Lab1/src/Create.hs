{-# LANGUAGE OverloadedStrings #-}

module Create where

import           Data.List
import           Data.Text.Conversions
import           Database.MySQL.Base
import           Utils

class Create a where
  createRow :: a -> [String] -> MySQLConn -> IO OK

instance Create TableName where
  createRow Students params conn =
    execute
      conn
      "INSERT INTO students (name, surname, enrollYear, groupId) VALUES(?,?,?,?)"
      [
        MySQLText (toText (head params)),
        MySQLText (toText (params !! 1)),
        MySQLInt32 (toNum (params !! 2)),
        MySQLInt32 (toNum (params !! 3))
      ]
  createRow Groups params conn =
    execute
      conn
      "INSERT INTO groups (name) VALUES(?)"
      [
        MySQLText (toText (head params))
      ]
  createRow Lecturers params conn =
    execute
      conn
      "INSERT INTO lecturers (name,surname) VALUES(?,?)"
      [
        MySQLText (toText (head params)),
        MySQLText (toText (params !! 1))
      ]
  createRow Themes params conn =
    execute
      conn
      "INSERT INTO themes (name,additionalInfo) VALUES(?,?)"
      [
        MySQLText (toText (head params)),
        MySQLText (toText (params !! 1))
      ]
  createRow ThemeProgresses params conn =
    execute
      conn
      "INSERT INTO themeProgresses (studentId, themeId, progressPercentage) VALUES(?,?,?)"
      [
        MySQLInt32 (toNum (head params)),
        MySQLInt32 (toNum (params !! 1)),
        MySQLInt32 (toNum (params !! 2))
      ]
  createRow Timetable params conn =
    execute
      conn
      "INSERT INTO timetable (lecturerId, themeId, groupId, lessonDate) VALUES(?,?,?,?)"
      [
        MySQLInt32 (toNum (head params)),
        MySQLInt32 (toNum (params !! 1)),
        MySQLInt32 (toNum (params !! 2)),
        MySQLDateTime (toDate (params !! 3))
      ]
  createRow Qna params conn =
    execute
      conn
      "INSERT INTO qna (studentId, lecturerId, question, answer) VALUES(?,?,?,?)"
      [
        MySQLInt32 (toNum (head params)),
        MySQLInt32 (toNum (params !! 1)),
        MySQLText (toText (params !! 2)),
        MySQLText (toText (params !! 3))
      ]

createRowManager :: TableName -> MySQLConn -> IO ()
createRowManager tableName conn = do
  putStrLn "Enter column values separated by Enter:"
  putStrLn (intercalate "\n" (tableColumns tableName))
  case tableName of
    Students -> do
      field0 <- getLine
      field1 <- getLine
      field2 <- getLine
      field3 <- getLine
      createRow tableName [field0, field1, field2, field3] conn
    Groups -> do
      field0 <- getLine
      createRow tableName [field0] conn
    Lecturers -> do
      field0 <- getLine
      field1 <- getLine
      createRow tableName [field0, field1] conn
    Themes -> do
      field0 <- getLine
      field1 <- getLine
      createRow tableName [field0, field1] conn
    ThemeProgresses -> do
      field0 <- getLine
      field1 <- getLine
      field2 <- getLine
      createRow tableName [field0, field1, field2] conn
    Timetable -> do
      field0 <- getLine
      field1 <- getLine
      field2 <- getLine
      field3 <- getLine
      createRow tableName [field0, field1, field2, field3] conn
    Qna -> do
      field0 <- getLine
      field1 <- getLine
      field2 <- getLine
      field3 <- getLine
      createRow tableName [field0, field1, field2, field3] conn
  putStrLn "1 row inserted"
