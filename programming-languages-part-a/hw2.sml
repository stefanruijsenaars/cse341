(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

(* (a) Write a function all_except_option, which takes a string and a string list. Return NONE if the
string is not in the list, else return SOME lst where lst is identical to the argument list except the string
is not in it. You may assume the string is in the list at most once. Use same_string, provided to you,
to compare strings. Sample solution is around 8 lines. *)
fun all_except_option(word : string, items : string list) =
  let fun get_filtered_list(items) =
    case items of
        [] => []
      | x::xs'  => if same_string(x,word)
		   then get_filtered_list(xs')
	       	   else x::get_filtered_list(xs')
  in
      let
	  val filtered = get_filtered_list(items)
      in 
          if filtered = items then NONE else SOME filtered
      end 
  end
      
(* (b) Write a function get_substitutions1, which takes a string list list (a list of list of strings, the
substitutions) and a string s and returns a string list. The result has all the strings that are in
some list in substitutions that also has s, but s itself should not be in the result. *)
fun get_substitutions1(substitutions : string list list, name : string) =
  case substitutions of
      [] => []
    | x::xs' => case all_except_option(name, x) of
		   SOME items => items @ get_substitutions1(xs', name)
		 |  NONE => get_substitutions1(xs', name)

(* (c) Write a function get_substitutions2, which is like get_substitutions1 except it uses a tail-recursive
local helper function. *)					      
fun get_substitutions2(substitutions : string list list, name : string) =
  let fun aux(substitutions, name, acc) =
      case substitutions of
          [] => acc
        | x::xs' => case all_except_option(name, x) of
		        SOME items => aux(xs', name, acc @ items)
	  	     |  NONE => aux(xs', name, acc)
  in
      aux(substitutions, name, [])
  end

(* (d) Write a function similar_names, which takes a string list list of substitutions (as in parts (b) and
(c)) and a full name of type {first:string,middle:string,last:string} and returns a list of full
names (type {first:string,middle:string,last:string} list). The result is all the full names you
can produce by substituting for the first name (and only the first name) using substitutions and parts (b)
or (c). The answer should begin with the original name (then have 0 or more other names). *)
fun similar_names(substitutions : string list list, full_name : {first:string,middle:string,last:string}) =
  let val {first=x, middle=y,last=z} = full_name
  in
      let fun substitute_name(new_name : string) =
	    [{first=new_name,middle=y,last=z}]
      in
	 let fun recurse(items) =
            case items of
               [] => []
             | name::names' => substitute_name(name) @ recurse(names')
	 in
	     full_name::recurse(get_substitutions1(substitutions, x))
	 end
     end
end


(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)

(* (a) Write a function card_color, which takes a card and returns its color (spades and clubs are black,
diamonds and hearts are red). Note: One case-expression is enough. *)

fun card_color(card_suit : suit, card_rank : rank)  =
  case card_suit of
      Clubs => Black
   |  Diamonds => Red
   |  Hearts => Red
   |  Spades => Black

(* (b) Write a function card_value, which takes a card and returns its value (numbered cards have their
number as the value, aces are 11, everything else is 10). Note: One case-expression is enough. *)

fun card_value(card_suit : suit, card_rank : rank)  =
  case card_rank of
      Num x => x
   |  Ace => 11
   |  King => 10
   |  Jack => 10
   |  Queen => 10

(* (c) Write a function remove_card, which takes a list of cards cs, a card c, and an exception e. It returns a
list that has all the elements of cs except c. If c is in the list more than once, remove only the first one.
If c is not in the list, raise the exception e. You can compare cards with =. *)

fun remove_card(cs : card list, c : card, e : exn) =
  let fun aux(cs, c, e, num_removed : int) =
    case cs of
       [] => if num_removed = 0 then raise e else []
     |  x::xs' => if x = c andalso num_removed = 0
		  then aux(xs', c, e, num_removed + 1)
		  else x::aux(xs', c, e, num_removed)
  in
      aux(cs, c, e, 0)
  end

(* (d) Write a function all_same_color, which takes a list of cards and returns true if all the cards in the
list are the same color. Hint: An elegant solution is very similar to one of the functions using nested
pattern-matching in the lectures. *)

fun all_same_color(cs : card list) =
  case cs of
      [] => true
    | _::[] => true
    | head::neck::rest => card_color(head) = card_color(neck) andalso all_same_color(neck::rest)
										       

(* (e) Write a function sum_cards, which takes a list of cards and returns the sum of their values. Use a locally
defined helper function that is tail recursive. (Take “calls use a constant amount of stack space” as a
requirement for this problem.) *)

fun sum_cards(cs : card list) =
  let fun aux(cs, acc) =
	case cs of
	    [] => acc
	  | x::xs' => aux(xs', acc + card_value(x))
  in
      aux(cs, 0)
  end
      
(* (f) Write a function score, which takes a card list (the held-cards) and an int (the goal) and computes
the score as described above. *)

fun score(cs : card list, goal : int) =
  let val sum = sum_cards(cs)
      val preliminary_score =
 	 if sum > goal
	 then 3 * (sum - goal)
	 else goal - sum
  in
    if all_same_color(cs)
    then preliminary_score div 2
    else preliminary_score
  end
      
(* (g) Write a function officiate, which "runs a game." It takes a card list
 (the card-list) a move list (what the player "does" at each point), and an int
 (the goal) and returns the score at the end of the game after processing (some or all of)
 the moves in the move list in order. Use a locally defined recursive helper function that
 takes several arguments that together represent the current state of the game.
 As described above:
 The game starts with the held-cards being the empty list.
 The game ends if there are no more moves. (The player chose to stop since the move list is empty.)
 If the player discards some card c, play continues (i.e., make a recursive call) with the held-cards
not having c and the card-list unchanged. If c is not in the held-cards, raise the IllegalMove
exception.
 If the player draws and the card-list is (already) empty, the game is over.
 Else if drawing causes the sum of the held-cards to exceed the goal, the game is
 over (after drawing). Else play continues with a larger held-cards and a smaller card-list.
Sample solution for (g) is under 20 lines.) *)

fun officiate(cs: card list, ms: move list, goal: int) =
  let fun play(held_cards : card list, deck : card list, moves : move list) =
	let
	    fun game_over() = score(held_cards, goal)
	    fun draw_card(remaining_moves : move list) =
	       case deck of
	          (* cards list empty: game over *)
	          [] => game_over()
	          (* move card from cards list to held cards *)
	        | c::cs' => if sum_cards(c::held_cards) > goal
			    then score(c::held_cards, goal)
			    else play(c::held_cards, cs', remaining_moves)
	in
	    case moves of
	        [] => game_over()
	      | Draw::xs' => draw_card(xs')
	      | Discard x::xs' => play(remove_card(deck, x, IllegalMove), deck, xs')
	end
  in
       play([], cs, ms)
  end
