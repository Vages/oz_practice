%P57
declare
proc {Max X Y ?Z}
   if X>=Y then Z=X else Z=Y end
end

declare C 
{Max 3 8 C}

{Browse C}

%P89
declare A B C in
C=A+B
{Browse C}
A=10
B=200

%P92
declare
fun {Eval E}
   if {IsNumber E} then E
   else
      case E of plus(X Y) then {Eval X}+{Eval Y}
      [] times(X Y) then {Eval X}*{Eval Y}
      else raise illFormedExpr(E) end
      end
   end
end

try
   {Browse {Eval plus(plus(5 5) 10)}}
   {Browse {Eval times(6 11)}}
   {Browse {Eval minus(7 10)}}
catch illFormedExpr(E) then
   {Browse '*** Illegal expression '#E#' ***'}
end

