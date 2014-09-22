{Browse 9999*9999}

declare
V=9999*9999

{Browse V*V}

declare
fun {Fact N}
   if N==0 then 1 else N*{Fact N-1} end
end

{Browse {Fact 10}}

declare
fun {Comb N K}
   {Fact N} div ({Fact K}*{Fact N-K})
end


{Browse {Comb 10 3}}

{Browse [5 6 7 8]}

declare Pascal AddList ShiftLeft ShiftRight
fun {Pascal N}
   if N==1 then [1]
   else
      {AddList {ShiftLeft {Pascal N-1}} {ShiftRight {Pascal N-1}}}
   end
end

fun {ShiftLeft L}
   case L of H|T then
      H|{ShiftLeft T}
   else [0] end
end

fun {ShiftRight L} 0|L end

fun {AddList L1 L2}
   case L1 of H1|T1 then
      case L2 of H2|T2 then
	 H1+H2|{AddList T1 T2}
      end
   else nil end
end

{Browse {Pascal 20}}

fun {FastPascal N}
   if N==1 then [1]
   else L in
      L={FastPascal N-1}
      {AddList {ShiftLeft L} {ShiftRight L}}
   end
end

{Browse {FastPascal 30}}

declare
fun lazy {Ints N}
   N|{Ints N+1}
end

declare
L={Ints 0}

{Browse L.1}
{Browse L.2.1}

case L of A|B|C|_ then {Browse A+B+C} end

declare
fun lazy {PascalList Row}
   Row|{PascalList {AddList {ShiftLeft Row} {ShiftRight Row}}}
end

declare
L={PascalList [1]}
{Browse L.2.2.2.1}

%Chapter 1.9%
declare GenericPascal OpList Add Xor
fun {GenericPascal Op N}
   if N==1 then [1]
   else L in
      L={GenericPascal Op N-1}
      {OpList Op {ShiftLeft L} {ShiftRight L}}
   end
end

fun {OpList Op L1 L2}
   case L1 of H1|T1 then
      case L2 of H2|T2 then
	 {Op H1 H2}|{OpList Op T1 T2}
      end
   else nil end
end

fun {Add X Y} X+Y end

fun {Xor X Y} if X == Y then 0 else 1 end end

{Browse {GenericPascal Xor 5}}

%Ch 1.11%

declare X in
thread {Delay 10000} X=99 end
{Browse start} {Browse X*X}

%Ch 1.12%

declare
C={NewCell 0}
C:=@C+1
{Browse @C}

%Ch 1.13

declare
local C in C={NewCell 0}
   fun {Bump}
      C:=@C+1
      @C
   end
   fun {Read}
      @C
   end
end

{Browse {Bump}}
{Browse {Bump}}

%Ch 1.14

declare
fun {NewCounter}
   C Bump Read in
   C={NewCell 0}
   fun {Bump}
      C:=@C+1
      @C
   end
   fun {Read}
      @C
   end
   counter(bump:Bump read:Read)
end

declare
Ctr1={NewCounter}
Ctr2={NewCounter}

{Browse {Ctr1.bump}}
{Browse {Ctr2.bump}}