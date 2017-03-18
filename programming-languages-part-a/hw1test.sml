(* Homework1 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

use "hw1.sml";


val test1 = is_older ((1,2,3),(2,3,4)) = true
val test1a = is_older ((1,2,3),(1,2,4)) = true
val test1b = is_older ((1,2,4),(1,2,3)) = false 
val test1c = is_older ((1,2,4),(1,2,4)) = false 

val test2 = number_in_month ([(2012,2,28),(2013,12,1)],2) = 1
val test2a = number_in_month ([(2012,2,28),(2013,2,1)],2) = 2
val test2b = number_in_month ([(2012,2,28),(2013,12,1)],3) = 0
val test2c = number_in_month ([],2) = 0

val test3 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 3
val test3a = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[]) = 0
val test3b = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[4]) = 1
val test3c = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[5]) = 0

val test4 = dates_in_month ([(2012,2,28),(2013,12,1)],2) = [(2012,2,28)]
val test4a = dates_in_month ([(2012,2,28),(2013,12,1)],12) = [(2013,12,1)]
val test4b = dates_in_month ([(2012,2,28),(2013,12,1)],3) = []
val test4c = dates_in_month ([],2) = []
val test4d = dates_in_month ([(2012,2,28),(2013,2,1)],2) = [(2012,2,28),(2013,2,1)]

val test5 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)]
val test5a = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[5]) = []
val test5b = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[4,5,6]) = [(2011,4,28)]
val test5c = dates_in_months ([],[2,3,4]) = []

val test6 = get_nth (["hi", "there", "how", "are", "you"], 2) = "there"
val test6a = get_nth (["hi", "there", "how", "are", "you"], 1) = "hi"

val test7 = date_to_string (2013, 6, 1) = "June 1, 2013"
val test7a = date_to_string (2013, 1, 1) = "January 1, 2013"

val test8 = number_before_reaching_sum (10, [1,2,3,4,5]) = 3
val test8a = number_before_reaching_sum (1, [1,2,3,4,5]) = 0
val test8b = number_before_reaching_sum (3, [1,2,3,4,5]) = 1

val test9 = what_month 70 = 3
val test9a = what_month 1 = 1
val test9b = what_month 31 = 1
val test9c = what_month 32 = 2
val test9d = what_month 365 = 12
val test9e = what_month 363 = 12

val test10 = month_range (31, 34) = [1,2,2,2]
val test10a = month_range (30, 34) = [1,1,2,2,2]
val test10b = month_range (30, 30) = [1]
val test10c = month_range (30, 29) = []
val test10d = month_range (364, 365) = [12,12]

val test11 = oldest([(2012,2,28),(2011,3,31),(2011,4,28)]) = SOME (2011,3,31)
val test11a = oldest([]) = NONE
val test11b = oldest([(2012,2,28)]) = SOME (2012,2,28)
(*
val test12 = number_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[3,2,2,3,3,3,4,4]) = 3
val test12a = number_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 3
val test12b = number_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[]) = 0
val test12c = number_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[4,4]) = 1
val test12d = number_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[5,5]) = 0
val test12e = number_in_months_challenge ([],[5,5]) = 0

val test13 = dates_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[3,2,2,3,3,3,4,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)]
val test13a = dates_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)]
val test13b = dates_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[]) = []
val test13c = dates_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[4,4]) = [(2011,4,28)]
val test13d = dates_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[5,5]) = []
val test13e = dates_in_months_challenge ([],[5,5]) = []

val test14a = reasonable_date ((0, 1, 1)) = false
val test14b = reasonable_date ((1, 1, 1)) = true
val test14c = reasonable_date ((1, 0, 1)) = false
val test14d = reasonable_date ((1, 1, 0)) = false
val test14e = reasonable_date ((1, 13, 1)) = false
val test14f = reasonable_date ((1, 12, 1)) = true
val test14g = reasonable_date ((1, 12, 31)) = true
val test14h = reasonable_date ((1, 12, 32)) = false
val test14i = reasonable_date ((1, 2, 29)) = false
val test14j = reasonable_date ((400, 2, 29)) = true
val test14k = reasonable_date ((401, 2, 29)) = false
val test14l = reasonable_date ((2004, 2, 29)) = true
val test14m = reasonable_date ((1700, 2, 29)) = false
*)
