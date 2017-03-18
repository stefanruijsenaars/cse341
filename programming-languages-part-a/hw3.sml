(* Coursera Programming Languages, Homework 3 *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(* 1. Write a function only_capitals that takes a string list and returns a string list that has only the strings in the argument that start with an uppercase letter. Assume all strings have at least 1 character. Use List.filter, Char.isUpper, and String.sub to make a 1-2 line solution. *)
			       
val only_capitals = List.filter (fn y => Char.isUpper (String.sub (y, 0)))

(* 2. Write a function longest_string1 that takes a string list and returns the longest string in the list. If the list is empty, return "". In the case of a tie, return the string closest to the beginning of the list. Use foldl, String.size, and no recursion (other than the implementation of foldl is recursive). *)
				
val longest_string1 = List.foldl (fn (x, y) =>
				     if String.size(x) > String.size(y)
				     then x
				     else y
				 ) "";

(* 3. Write a function longest_string2 that is exactly like longest_string1 except in the case of ties it returns the string closest to the end of the list. Your solution should be almost an exact copy of longest_string1. Still use foldl and String.size. *)

val longest_string2 = List.foldl (fn (x, y) =>
				     if String.size x >= String.size y
				     then x
				     else y
				 ) ""

(* 4. Write functions longest_string_helper, longest_string3, and longest_string4 such that .. *)
				 
val longest_string_helper =
 fn f =>
    fn items =>
         List.foldl (fn (string1, string2) =>
		      if f (String.size string1, String.size string2)
		      then string1
		      else string2
		    ) "" items
	   

val longest_string3 = longest_string_helper (fn (x,y) => x > y) 

val longest_string4 = longest_string_helper (fn (x,y) => x >= y)

(* 5. Write a function longest_capitalized that takes a string list and returns the longest string in the list that begins with an uppercase letter, or "" if there are no such strings. Assume all strings have at least 1 character. Use a val-binding and the ML library’s o operator for composing functions. Resolve ties like in problem 2. *)
					    
val longest_capitalized = longest_string1 o only_capitals

(* 6. Write a function rev_string that takes a string and returns the string that is the same characters in reverse order. Use ML’s o operator, the library function rev for reversing lists, and two library functions in the String module. (Browse the module documentation to find the most useful functions.) *)
						
val rev_string = String.implode o List.rev o String.explode
						  
(* 7. Write a function first_answer of type (’a -> ’b option) -> ’a list -> ’b (notice the 2 arguments are curried). The first argument should be applied to elements of the second argument in order until the first time it returns SOME v for some v and then v is the result of the call to first_answer. If the first argument returns NONE for all list elements, then first_answer should raise the exception NoAnswer. *)
						 
fun first_answer f items =
       case items of
	  []  => raise NoAnswer 
	| item::items' => case f item of
			       SOME v => v
			     | NONE => first_answer f items'
							 
(* 8. Write a function all_answers of type (’a -> ’b list option) -> ’a list -> ’b list option
(notice the 2 arguments are curried). The first argument should be applied to elements of the second
argument. If it returns NONE for any element, then the result for all_answers is NONE. Else the
calls to the first argument will have produced SOME lst1, SOME lst2, ... SOME lstn and the result of
all_answers is SOME lst where lst is lst1, lst2, ..., lstn appended together (order doesn’t matter).
Hints: The sample solution is 8 lines. It uses a helper function with an accumulator and uses @. Note
all_answers f [] should evaluate to SOME [] *)

fun all_answers f items =
  let fun process_items (xs, acc) =						      
    case xs of
      [] => SOME acc
     | x::xs' => case f x of
		     NONE => NONE
		  |  SOME v => process_items (xs', v @ acc)
  in
      process_items (items, [])
  end

(* 9. (This problem uses the pattern datatype but is not really about pattern-matching.) A function g has
been provided to you.
(a) Use g to define a function count_wildcards that takes a pattern and returns how many Wildcard
patterns it contains.
(b) Use g to define a function count_wild_and_variable_lengths that takes a pattern and returns
the number of Wildcard patterns it contains plus the sum of the string lengths of all the variables
in the variable patterns it contains. (Use String.size. We care only about variable names; the
constructor names are not relevant.)
(c) Use g to define a function count_some_var that takes a string and a pattern (as a pair) and
returns the number of times the string appears as a variable in the pattern. We care only about
variable names; the constructor names are not relevant. *)
		    
val count_wildcards = g (fn x => 1) (fn x => 0)

val count_wild_and_variable_lengths = g (fn x => 1) (fn x => String.size x)

val count_some_var = fn (var_name, p) =>
			g (fn x => 0) (fn x => if x = var_name then 1 else 0) p

			  
(* 10. Write a function check_pat that takes a pattern and returns true if and only if all the variables
appearing in the pattern are distinct from each other (i.e., use different strings). The constructor
names are not relevant. *)
			  
val check_pat = fn pat =>
  let fun get_names p = case p of
 			    Variable name => [name]
			  | TupleP ps => List.foldl (fn (x, y) => y @ (get_names x)) [] ps
		          | ConstructorP(_,cp) => get_names cp
			  | _ => []
      fun has_repeats xs = case xs of
			      [] => false
			    | x::xs' => (List.exists (fn y => y = x) xs') orelse (has_repeats xs')
  in
      not (has_repeats (get_names pat))
  end

(* 11. Write a function match that takes a valu * pattern and returns a (string * valu) list option,
namely NONE if the pattern does not match and SOME lst where lst is the list of bindings if it does.
Note that if the value matches but the pattern has no patterns of the form Variable s, then the result
is SOME []. *)

fun match (v, p) =
  case (v, p) of
     (_, Wildcard) => SOME []
   | (_, Variable s) => SOME [(s, v)]
   | (Unit, UnitP) => SOME []
   | (Const x, ConstP y) => if x = y
			    then SOME []
			    else NONE
   | (Tuple vs, TupleP ps) => if List.length ps = List.length vs			      
			      then all_answers match (ListPair.zip (vs, ps))
		  	      else NONE
   | (Constructor (s2, v), ConstructorP (s1, p)) => if s1 = s2
				              then match (v, p)
					      else NONE
   | (_, _) => NONE 


fun first_match v ps  =
  SOME (first_answer (fn p => match (v, p)) ps) handle NoAnswer => NONE
