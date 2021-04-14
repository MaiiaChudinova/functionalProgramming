{-# LANGUAGE OverloadedStrings #-}

import           Create
import           Data.List
import           Database.MySQL.Base
import           Delete
import           FindById
import           ListAll
import           System.Exit
import           Update
import           Utils

main = do
  conn <-
    connect
      defaultConnectInfo
        {
          ciUser = "sql11405509",
          ciPassword = "gn3b7PQRbP",
          ciDatabase = "sql11405509",
          ciHost = "sql11.freemysqlhosting.net",
          ciPort = 3306
        }
  putStrLn "\nChoose table number:"
  putStrLn (unlines orderedTableNames)
  putStrLn "Else exit\n"
  number <- getLine
  let name = numberToTableName number
  putStrLn ""
  if checkTableName name
    then do
      putStrLn
        "Choose operation:\n1. Create\n2. Update\n3. Delete\n4. List all\n5. Find by id\nElse - go back\n"
      x <- getLine
      putStrLn name
      case x of
        "1" -> createRowManager (getTableName name) conn
        "2" -> updateRowManager name conn
        "3" -> deleteRowManager (getTableName name) conn
        "4" -> listAllManager (getTableName name) conn
        "5" -> findByManager (getTableName name) conn
        _   -> putStrLn "Back"
    else do
      putStrLn "Exit"
      close conn
      exitSuccess
  close conn
  main
