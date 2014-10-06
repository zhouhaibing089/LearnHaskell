describeList :: [a] -> String
describeList xs = "The list is " ++ case xs of  [] -> "empty"
                                                [x] -> "a singleton list"
                                                xs -> "a longer list"

describeListWhere :: [a] -> String
describeListWhere xs = "The list is " ++ what xs
    where   what [] = "empty."
            what [x] = "a singleton list."
            what xs = "a longer list."
