{-# LANGUAGE OverloadedStrings #-}

module Update where

import           Data.List
import           Data.Text.Conversions
import           Database.MySQL.Base
import           Utils

class Update a where
  updateRow :: a -> String -> String -> String -> MySQLConn -> IO OK

instance Update TableName where
  updateRow Students "name" value index conn =
    execute conn "UPDATE students SET name=? WHERE id=?" [MySQLText (toText value), MySQLInt32 (toNum index)]
  updateRow Students "surname" value index conn =
    execute conn "UPDATE students SET surname=? WHERE id=?" [MySQLText (toText value), MySQLInt32 (toNum index)]
  updateRow Students "groupId" value index conn =
    execute conn "UPDATE students SET groupId=? WHERE id=?" [MySQLInt32 (toNum value), MySQLInt32 (toNum index)]
  updateRow Groups "name" value index conn =
    execute conn "UPDATE groups SET name=? WHERE id=?" [MySQLText (toText value), MySQLInt32 (toNum index)]
  updateRow Lecturers "name" value index conn =
    execute conn "UPDATE lecturers SET name=? WHERE id=?" [MySQLText (toText value), MySQLInt32 (toNum index)]
  updateRow Lecturers "surname" value index conn =
    execute conn "UPDATE lecturers SET surname=? WHERE id=?" [MySQLText (toText value), MySQLInt32 (toNum index)]
  updateRow Themes "name" value index conn =
    execute conn "UPDATE themes SET name=? WHERE id=?" [MySQLText (toText value), MySQLInt32 (toNum index)]
  updateRow Themes "additionalInfo" value index conn =
    execute conn "UPDATE themes SET additionalInfo=? WHERE id=?" [MySQLText (toText value), MySQLInt32 (toNum index)]
  updateRow ThemeProgresses "progressPercentage" value index conn =
    execute conn "UPDATE themes SET progressPercentage=? WHERE id=?" [MySQLInt32 (toNum value), MySQLInt32 (toNum index)]
  updateRow Timetable "lecturerId" value index conn =
    execute conn "UPDATE timetable SET lecturerId=? WHERE id=?" [MySQLInt32 (toNum value), MySQLInt32 (toNum index)]
  updateRow Timetable "lessonDate" value index conn =
    execute conn "UPDATE timetable SET lessonDate=? WHERE id=?" [MySQLDateTime (toDate value), MySQLInt32 (toNum index)]
  updateRow Qna "answer" value index conn =
    execute conn "UPDATE qna SET answer=? WHERE id=?" [MySQLText (toText value), MySQLInt32 (toNum index)]

updateRowManager :: String -> MySQLConn -> IO ()
updateRowManager name conn =
  case name of
    _ -> do
      putStrLn "Update where rowId =  "
      index <- getLine
      putStrLn "Enter column: "
      putStrLn (intercalate "\n" (updatableTableColumns name))
      field <- getLine
      if checkUpdatableColumns name field
        then do
          putStrLn "New value: "
          value <- getLine
          updateRow (getTableName name) field value index conn
          putStrLn "1 row updated"
        else putStrLn "ERROR - Invalid identifier"
