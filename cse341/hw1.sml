(* http://courses.cs.washington.edu/courses/cse341/13sp/hw1.pdf *)

fun is_older (date1 : int*int*int, date2 : int*int*int) =
    if (#1 date1) < (#1 date2)
    then true (* year 1 is smaller *)
    else if (#1 date1) > (#1 date2)
    then false (* year 1 is larger *)
    (* year is the same *)
    else if (#2 date1) < (#2 date2)
    then true (* month 1 is smaller *)
    else if (#2 date1) > (#2 date2) (* mont h1 is larger *)
    then false
    (* month is the same *)
    else (#3 date1) < (#3 date2) (* check whether day1 is smaller *)

fun number_in_month (date_list : (int*int*int) list, month : int) =
    if null date_list
    then 0
    else if (#2 (hd date_list) = month)
    then (1 + number_in_month(tl date_list, month))
    else (number_in_month(tl date_list, month))

fun number_in_months (date_list : (int*int*int) list, month_list : int list) =
    if null month_list
    then 0
    else number_in_month(date_list, hd month_list) + number_in_months(date_list, tl month_list)

fun dates_in_month (date_list : (int*int*int) list, month : int) =
    if null date_list
    then []
    else if (#2 (hd date_list) = month)
    then ((hd date_list)::dates_in_month(tl date_list, month))
    else (dates_in_month(tl date_list, month))    

fun dates_in_months (date_list : (int*int*int) list, month_list : int list) =
    if null month_list
    then []
    else dates_in_month(date_list, hd month_list) @ dates_in_months(date_list, tl month_list)

fun get_nth (string_list : string list, n : int) =
    if n = 1
    then hd string_list
    else get_nth(tl string_list, n - 1)


fun date_to_string (date : int*int*int) =
    let val months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    in
	get_nth(months, #2 date) ^ " " ^ Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)
    end

fun number_before_reaching_sum (sum : int, positive : int list) =
    if sum - hd positive <= 0
    then 0
    else 1 + number_before_reaching_sum(sum - hd positive, tl positive)

fun what_month (day_of_year : int) =
    let val month_lengths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    in
        1 + number_before_reaching_sum(day_of_year, month_lengths)
    end

fun month_range (day1 : int, day2 : int) =
    if day1 > day2
    then []
    else what_month(day1)::month_range (day1 + 1, day2)

fun oldest (date_list : (int*int*int) list) =
    if null date_list
    then NONE
    else
        let
	    fun oldest_value (date_list : (int*int*int) list) =
	        if null (tl date_list)
	        then hd date_list
	        else
	  	    let val tl_ans = oldest_value(tl date_list)
		    in
		        if is_older(hd date_list, tl_ans)
		        then hd date_list
		        else tl_ans
		    end
	in
	    SOME (oldest_value date_list)
        end
