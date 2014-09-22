%Import Visualizer
\insert 'Visualizer.oz'

%Reimplementation of list functions
declare Length Take Drop Append Member Position

fun {Length Xs}
   case Xs of nil then
      0
   [] H|T then
      1 + {Length T}
   end
end

fun {Take Xs N}
   if N<1 then
      nil
   else
      case Xs of nil then
	 nil
      [] H|T then
	 H|{Take T N-1}
      end
   end
end

fun {Drop Xs N}
   if N < 1 then
      Xs
   else
      case Xs of _|T then
	 {Drop T N-1}
      [] nil then
	 nil
      end
   end
end

fun {Append Xs Ys}
   case Xs of nil then
      Ys
   [] H|T then
      H|{Append T Ys}
   end
end

fun {Member Xs Y}
   case Xs of nil then
      false
   [] H|T then
      if H == Y then
	 true
      else
	 {Member T Y}
      end
   end
end

fun {Position Xs Y}
   case Xs of H|T then
      if H == Y then
	 1
      else
	 1+{Position T Y}
      end
   end
end

%Test of visualizer
Test_states = [state(main:[a b] trackA:nil trackB:nil)
state(main:[a] trackA:[b] trackB:nil)
state(main:nil trackA:[b] trackB:[a])
	       state(main:[b] trackA:nil trackB:[a])]

{Visualize Test_states}

