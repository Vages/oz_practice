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

{Browse L}
