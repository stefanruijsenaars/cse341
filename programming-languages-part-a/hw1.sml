fun is_older (date1 : int * int * int, date2 : int * int * int) =
  if (#1 date1 < #1 date2)
  orelse (#1 date1 = #1 date2 andalso #2 date1 < #2 date2)
  orelse (#1 date1 = #1 date2 andalso #2 date1 = #2 date2 andalso #3 date1 < #3 date2)
  then true
  else false;

fun number_in_month (dates : (int * int * int) list, month : int) =
  if null dates
  then 0
  else if (#2 (hd dates)) = month
  then number_in_month(tl dates, month) + 1
  else number_in_month(tl dates, month);

fun number_in_months (dates : (int * int * int) list, months : int list) =
  if null months
  then 0
  else number_in_month(dates, hd months) + number_in_months(dates, tl months);
		       
fun dates_in_month (dates :  (int * int * int) list, month : int) =
  if null dates
  then []
  else if (#2 (hd dates)) = month
  then (hd dates)::dates_in_month(tl dates, month)
  else dates_in_month(tl dates, month);

fun dates_in_months (dates : (int * int * int) list, months : int list) =
  if null months
  then []
  else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months);

fun get_nth (string_list : string list, n : int) =
  if n = 1
  then hd string_list
  else get_nth(tl string_list, n-1);
	      
fun date_to_string (date : int * int * int) =
  let val months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
  in
    get_nth(months, #2 date) ^ " " ^ Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)
  end;

fun number_before_reaching_sum (sum : int, num_list : int list) =
  if sum - hd num_list <= 0
  then 0
  else 1 + number_before_reaching_sum(sum - hd num_list, tl num_list);

 
fun what_month (day_of_year : int) =
  let val num_days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31, 30, 31]
  in
      1 + number_before_reaching_sum(day_of_year, num_days)
  end;
      
fun month_range (day1 : int, day2 : int) =
  if (day2 < day1)
  then []
  else what_month(day1)::month_range(day1 + 1, day2);

fun oldest (date_list : (int * int * int) list) =
  if null date_list
  then NONE
  else let fun oldest_value (dates : (int * int * int) list) =
	     if null (tl dates)
	     then hd dates (* if there only is one value anymore, then that is the oldest *)
	     else let
		 (* prevent this from being calculated twice *)
		 val oldest_in_tail = oldest_value(tl dates)
	     in
		 if (is_older(hd dates, oldest_in_tail))
	         then hd dates
                 else oldest_in_tail
	     end
       in
	   SOME (oldest_value(date_list))
       end
	   
	   
fun number_in_months_challenge (dates : (int * int * int) list, months : int list) =
  if null months
  then 0
  else let fun months_deduplicated (months : int list) =
	     let fun list_has_month (month : int, month_list : int list) =
		   if null month_list
		   then false
		   else if hd month_list = month
		   then true
		   else list_has_month(month, tl month_list)
	     in
		 if null months
		 then []
		 else if (list_has_month(hd months, tl months))
		 (* if the month is available further on in the list, drop it *)
		 then months_deduplicated(tl months)
	         (* if it's not, add it *)
		 else hd months::months_deduplicated(tl months)
	     end
       in number_in_months (dates, months_deduplicated(months))
       end
	   
	   
fun dates_in_months_challenge (dates : (int * int * int) list, months : int list) =
  if null months
  then []
  else let fun months_deduplicated (months : int list) =
	     let fun list_has_month (month : int, month_list : int list) =
		   if null month_list
		   then false
		   else if hd month_list = month
		   then true
		   else list_has_month(month, tl month_list)
	     in
		 if null months
		 then []
		 else if (list_has_month(hd months, tl months))
		 (* if the month is available further on in the list, drop it *)
		 then months_deduplicated(tl months)
	         (* if it's not, add it *)
		 else hd months::months_deduplicated(tl months)
	     end
       in dates_in_months (dates, months_deduplicated(months))
       end
	   
fun reasonable_date (date : int * int * int) =
  let fun is_leap_year (year : int) =
	year mod 400 = 0 orelse (year mod 4 = 0 andalso year mod 100 <> 0)
  in
    let fun days_in_month (month : int) =
	if month = 1
	then 31
	else if (month = 2 andalso is_leap_year(#1 date))
	then 29
	else if month = 2
	then 28
	else if month = 3
	then 31
	else if month = 4
	then 30
	else if month = 5
	then 31
	else if month = 6
	then 30
	else if month = 7
	then 31
	else if month = 8
	then 31
	else if month = 9
	then 30
	else if month = 10
	then 31
	else if month = 11
	then 30
	else if month = 12
	then 31
	else 0	    
    in
      not (
        #1 date <= 0
        orelse #2 date < 1
        orelse #2 date > 12
        orelse #3 date < 1
        orelse (#3 date > days_in_month(#2 date))
      )
    end
  end
      
