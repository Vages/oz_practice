%Import Visualizer
\insert 'Visualizer.oz'
\insert 'list.oz'

%Test of visualizer
Test_states = [state(main:[a b] trackA:nil trackB:nil)
	       state(main:[a] trackA:[b] trackB:nil)
	       state(main:nil trackA:[b] trackB:[a])
	       state(main:[b] trackA:nil trackB:[a])]

{Visualize Test_states}

%Task2 Apply moves
%S is State, ML is MoveList

declare
fun {ApplyMoves S ML}
   if ML == nil then
      nil
   else
      local New_S in
	 case ML of H|T then
	    case H of trackA(N) then
	       local LenM LenA Main TrackA in
		  Main = S.main
		  TrackA = S.trackA
		  LenM = {Length Main}
		  LenA = {Length TrackA}
	       
		  if N>0 then
		     New_S = state(main:{Take Main LenM-N} trackA:{Append {Drop Main LenM-N} TrackA} trackB:S.trackB)
		  elseif N<0 then
		     New_S = state(main:{Append Main {Take TrackA {Abs N}}} trackA:{Drop TrackA {Abs N}} trackB:S.trackB)
		  else
		     New_S = S
		  end %End of if
	       end %End of local statement for A
	    [] trackB(N) then
	       local LenM LenB Main TrackB in
		  Main = S.main
		  TrackB = S.trackB
		  LenM = {Length Main}
		  LenB = {Length TrackB}
	       
		  if N>0 then
		     New_S = state(main:{Take Main LenM-N} trackB:{Append {Drop Main LenM-N} TrackB} trackA:S.trackA)
		  elseif N<0 then
		     New_S = state(main:{Append Main {Take TrackB {Abs N}}} trackB:{Drop TrackB {Abs N}} trackA:S.trackA)
		  else
		     New_S = S
		  end %End of if
	       end %End of local statement for B
	       New_S|{ApplyMoves New_S T} % This is the recursive call
	    end %End of trackA and trackB
	 end %End of ML case H|T
      end % End of local New_S	 
   end
end

{Browse {ApplyMoves state(main[a b] trackA:nil trackB:nil) [trackA(1) trackB(1) trackA(~1)]}}

% OK, this should be working