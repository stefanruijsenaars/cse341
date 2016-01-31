use "hw1.sml";

val test1 = is_older((2000, 1, 1), (2000, 1, 1)) = false;

val test2 = is_older((2001, 1, 1), (2000, 1, 1)) = false;
 
val test3 = is_older((2000, 1, 1), (2001, 1, 1));

val test4 = is_older((2000, 1, 1), (2000, 2, 1));

val test5 = is_older((2000, 2, 2), (2000, 2, 1)) = false;			

val test6 = is_older((2000, 1, 1), (2000, 1, 2));

val test7 = number_in_month([(2000, 1, 1), (2000, 2, 1), (2000, 1, 2)], 1) = 2;

val test8 = number_in_month([(2000, 1, 1), (2000, 2, 1), (2000, 1, 2)], 2) = 1;

val test9 = number_in_month([(2000, 1, 1), (2000, 2, 1), (2000, 1, 2)], 3) = 0;

val test10 = number_in_month([(2000, 1, 1), (2000, 2, 1), (2000, 1, 2), (2000, 2, 2), (2000, 2, 3)], 2) = 3;

val test11 = number_in_month([(2000, 1, 1)], 12) = 0;

val test12 = number_in_month([(2000, 12, 1)], 12) = 1;

val test13 = number_in_months([(2000, 1, 1), (2000, 2, 1), (2000, 1, 2)], [1]) = 2;

val test14 = number_in_months([(2000, 1, 1), (2000, 2, 1), (2000, 1, 2)], [1, 2]) = 3;

val test15 = number_in_months([(2000, 1, 1), (2000, 2, 1), (2000, 1, 2)], [1, 2, 3]) = 3;

val test16 = number_in_months([(2000, 1, 1), (2000, 2, 1), (2000, 1, 2)], [2]) = 1;

val test17 = number_in_months([(2000, 1, 1), (2000, 2, 1), (2000, 1, 2)], [3]) = 0;

val test18 = dates_in_month([(2000, 1, 1), (2000, 2, 1), (2000, 1, 2)], 1) = [(2000, 1, 1), (2000, 1, 2)]

val test19 = dates_in_month([(2000, 1, 1), (2000, 2, 1), (2000, 1, 2)], 2) = [(2000, 2, 1)]

val test20 = dates_in_month([(2000, 1, 1), (2000, 2, 1), (2000, 1, 2)], 3) = []

val test21 = dates_in_months([(2000, 1, 1), (2000, 2, 1), (2000, 1, 2)], [1]) = [(2000, 1, 1), (2000, 1, 2)];

val test22 = dates_in_months([(2000, 1, 1), (2000, 2, 1), (2000, 1, 2)], [1, 2]) = [(2000, 1, 1), (2000, 1, 2), (2000, 2, 1)];

val test23 =  dates_in_months([(2000, 1, 1), (2000, 2, 1), (2000, 1, 2)], [1, 2, 3]) = [(2000, 1, 1), (2000, 1, 2), (2000, 2, 1)];

val test24 = dates_in_months([(2000, 1, 1), (2000, 2, 1), (2000, 1, 2)], [3]) = [];

val test25 = get_nth(["one", "two", "three"], 1) = "one";

val test26 = get_nth(["one", "two", "three"], 3) = "three";

val test27 = date_to_string((2000, 1, 1)) = "January 1, 2000"

val test28 = date_to_string((2000, 12, 31)) = "December 31, 2000"
						  
val test29 = number_before_reaching_sum(3, [2, 3, 4, 5]) = 1
							       
val test30 = number_before_reaching_sum(5, [2, 3, 4, 5]) = 1
							       
val test31 = number_before_reaching_sum(6, [2, 3, 4, 5]) = 2
							       
val test32 = number_before_reaching_sum(10, [2, 3, 4, 5]) = 3

val test33 = what_month(1) = 1
				 
val test34 = what_month(31) = 1
				  
val test35 = what_month(32) = 2
				  
val test36 = what_month(59) = 2
				  
val test37 = what_month(365) = 12				  

val test38 = month_range(31, 32) = [1, 2];

val test39 = month_range(31, 33) = [1, 2, 2];

val test40 = month_range(364, 365) = [12, 12];

val test41 = month_range(2, 1) = [];

val test42 = oldest([(2000, 1, 1), (1900, 1, 1), (1800, 1, 1), (2050, 1, 1)]) = SOME (1800, 1, 1)

val test43 = oldest([(2000, 1, 1)]) = SOME (2000, 1, 1)

val test44 = oldest([]) = NONE
