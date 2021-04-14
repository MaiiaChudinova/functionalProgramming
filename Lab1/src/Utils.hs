module Utils where

import           Data.Int
import           Data.Time

data TableName
  = Students
  | Groups
  | Lecturers
  | Themes
  | ThemeProgresses
  | Timetable
  | Qna

tableNames :: [String]
tableNames = ["Students", "Groups", "Lecturers", "Themes", "ThemeProgresses", "Timetable", "Qna"]

orderedTableNames :: [String]
orderedTableNames = ["1. Students", "2. Groups", "3. Lecturers", "4. Themes", "5. ThemeProgresses", "6. Timetable", "7. Qna"]

numberToTableName :: String -> String
numberToTableName "1" = "Students"
numberToTableName "2" = "Groups"
numberToTableName "3" = "Lecturers"
numberToTableName "4" = "Themes"
numberToTableName "5" = "ThemeProgresses"
numberToTableName "6" = "Timetable"
numberToTableName "7" = "Qna"
numberToTableName _   = "exit"

toNum :: String -> Int32
toNum str = fromInteger (read str :: Integer)

toDate :: String -> LocalTime
toDate dateStr = parseTimeOrError True defaultTimeLocale "%YYYY-%mm-%dd %H:%M" dateStr :: LocalTime

checkTableName :: String -> Bool
checkTableName name = name `elem` tableNames

tableColumns :: TableName -> [String]
tableColumns Students = ["name", "surname", "enrollYear", "groupId"]
tableColumns Groups = ["name"]
tableColumns Lecturers = ["name", "surname"]
tableColumns Themes = ["name", "additionalInfo"]
tableColumns ThemeProgresses = ["studentId", "themeId", "progressPercentage"]
tableColumns Timetable = ["lecturerId", "themeId", "groupId", "lessonDate"]
tableColumns Qna = ["studentId", "lecturerId", "question", "answer"]

updatableTableColumns :: String -> [String]
updatableTableColumns "Students" = ["name", "surname", "groupId"]
updatableTableColumns "Groups" = ["name"]
updatableTableColumns "Lecturers" = ["name", "surname"]
updatableTableColumns "Themes" = ["name", "additionalInfo"]
updatableTableColumns "ThemeProgresses" = ["progressPercentage"]
updatableTableColumns "Timetable" = ["lecturerId", "lessonDate"]
updatableTableColumns "Qna" = ["answer"]
updatableTableColumns x = []

checkUpdatableColumns :: String -> String -> Bool
checkUpdatableColumns tableName columnName = columnName `elem` updatableTableColumns tableName

getTableName :: String -> TableName
getTableName "Students"           = Students
getTableName "Groups"             = Groups
getTableName "Lecturers"          = Lecturers
getTableName "Themes"             = Themes
getTableName "ThemeProgresses"    = ThemeProgresses
getTableName "Timetable"          = Timetable
getTableName "Qna"                = Qna
