%Task1
{Show 'Hello World!'}

{Browse 'Hello World!'}

%Task2a

declare X Y Z
Y = 42
Z = 23
X = Y * Z

{Browse X}

%Task2b
declare A B
A = 'This is magic'
{Browse B}
B = A
% I think this is possible because all variables are immutable,
% and thus is it possible for the program to scan through
% the file and set all variables before it executes any functions.

%Task3a
declare
fun {Min X Y}
   if X < Y then
      X
   else
      Y
   end
end

%Task3b
declare
fun {IsBigger Number Threshold}
   Number > Threshold
end

%Task4

declare
Pi = 3.14

proc {Circle R}
   A D C in
   A = Pi*R*R
   D = 2.0*R
   C = Pi*D
   {Browse A}
   {Browse D}
   {Browse C}
end

{Circle 1.0}

% Task 5a
declare
fun {SumTo A B}
   if A == B then
      B
   else
      A + {SumTo A+1 B}
   end
end

{Browse {SumTo 0 2}}
{Browse {SumTo 3 5}}

declare
fun {Max X Y}
   if X == 0 then
      Y
   else if Y == 0 then
	   X
	else
	   1 + {Max X-1 Y-1}
	end
   end
end

{Browse {Max 3 2}}

% Task 7a
declare
fun {Length Xs}
   case Xs of H|T then
      1 + {Length T}
   else
      0
   end
end

Xs_test = [0 1 2 3 4]

{Browse {Length Xs_test}}

% Task 7b

declare
fun {Take Xs N}
   if N == 0 then
      nil
   else
      case Xs of H|T then
	 H|{Take T N-1}
      [] E|nil then
	 E
      [] nil then
	 nil
      end
   end
end

{Browse {Take Xs_test 2}}

% Task 7c

declare
fun {Drop Xs N}
   if N == 0 then
      Xs
   else
      case Xs of H|T then
	 {Drop T N-1}
      [] E|nil then
	 nil
      [] nil then
	 nil
      end
   end
end

{Browse {Drop Xs_test 2}}

% Task 7d
declare
fun {Append Xs Ys}
   if Xs == nil then
      Ys
   else
      case Xs of H|T then
	 H|{Append T Ys}
      end
   end
end

declare
Ys_test = [5 6]

{Browse {Append Xs_test Ys_test}}

% Task 7e

declare
fun {Member Xs Y}
   case Xs of H|T then
      if H == Y then
	 true
      else if T == nil then
	      false
	   else
	      {Member T Y}
	   end
      end
   end
end

{Browse {Member Xs_test 2}}
{Browse {Member Xs_test 1000}}

% Task 7f
declare
fun {Position Xs Y}
   case Xs of H|T then
      if H == Y then
	 1
      else
	 1 + {Position T Y}
      end
   end
end

{Browse {Position Xs_test 2}}

% Task 8
declare
Keys = ["local" "in" "if" "then" "else" "end"]
Operators = ["+" "-" "*" "/" "=" "=="]
Illegal = ["?" "\&"]

fun {Analyze L}
   if {List.member L Keys} then
      key(L)
   elseif {List.member L Operators} then
      op(L)
   elseif {Char.isUpper L.1} then
      id(L)
   elseif {List.member L Illegal} then
      illegal(L)
   else
      atom(L)
   end
end

fun {Tokenize Xs}
   case Xs of H|T then
      {Analyze H}|{Tokenize T}
   [] H|nil then
      {Analyze H}
   else
      nil
   end
end
