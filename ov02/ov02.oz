%Import Visualizer
\insert 'Visualizer.oz'
\insert 'list.oz'

%Test of visualizer
Test_states = [state(main:[a b] trackA:nil trackB:nil)
	       state(main:[a] trackA:[b] trackB:nil)
	       state(main:nil trackA:[b] trackB:[a])
	       state(main:[b] trackA:nil trackB:[a])]

%{Visualize Test_states}

%Task2 Apply moves
%S is State, ML is MoveList
declare
fun {ApplyMoves S ML}
   if ML == nil then
      S|nil
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
		     New_S = state(main:{Take Main LenM-N}
				   trackA:{Append {Drop Main LenM-N} TrackA}
				   trackB:S.trackB)
		  elseif N<0 then
		     New_S = state(main:{Append Main {Take TrackA {Abs N}}}
				   trackA:{Drop TrackA {Abs N}}
				   trackB:S.trackB)
		  else
		     New_S = S
		  end
	       end %End of local statement for A
	    [] trackB(N) then
	       local LenM LenB Main TrackB in
		  Main = S.main
		  TrackB = S.trackB
		  LenM = {Length Main}
		  LenB = {Length TrackB}
	       
		  if N>0 then
		     New_S = state(main:{Take Main LenM-N}
				   trackB:{Append {Drop Main LenM-N} TrackB}
				   trackA:S.trackA)
		  elseif N<0 then
		     New_S = state(main:{Append Main {Take TrackB {Abs N}}}
				   trackB:{Drop TrackB {Abs N}}
				   trackA:S.trackA)
		  else
		     New_S = S
		  end %End of if
	       end %End of local statement for B
	    end %End of trackA and trackB
	    S|{ApplyMoves New_S T} % This is the recursive call
	 end %End of ML case H|T
      end % End of local New_S	 
   end
end

%Test of Task 2
{Browse {ApplyMoves state(main:[a b] trackA:nil trackB:nil) [trackA(1) trackB(1) trackA(~1)]}}

%Task 3

%Define SplitTrain
declare
fun {SplitTrain Xs Y}
   local A Hs Ts in
      A = {Position Xs Y}
      Hs = {Take Xs A-1}
      Ts = {Drop Xs A}
      Hs#Ts
   end
end

% Tests (passed)
%{Browse {SplitTrain [a b c] a}}
%{Browse {SplitTrain [a b c] b}}

declare
fun {Find Xs Ys}
   case Ys of nil then
      nil
   [] H|T then
      local PosH LenHs LenTs Hs Ts Movs NewTrain in
	 LenHs = {Position Xs H}-1 
	 LenTs = {Length Xs}-LenHs
	 Hs#Ts = {SplitTrain Xs H}

	 Movs = [trackA(LenTs) trackB(LenHs) trackA(~LenTs) trackB(~LenHs)]
	 NewTrain = {Append Ts Hs}

	 {Append Movs {Find NewTrain T}}
      end
   end
end

% Test (Passed)
{Visualize {ApplyMoves state(main:[a b] trackA:nil trackB:nil) {Find [a b] [b a]}}}

% Task4
declare
fun {FewFind Xs Ys}
   case Ys of nil then
      nil
   [] H|T then
      if Xs.1 == H then
	 case Xs of _|Tx then
	    {FewFind Tx T}
	 end
      else
	 local PosH LenHs LenTs Hs Ts Movs NewTrain in
	    LenHs = {Position Xs H}-1
	    LenTs = {Length Xs}-LenHs
	    Hs#Ts = {SplitTrain Xs H}

	    Movs = [trackA(LenTs) trackB(LenHs) trackA(~LenTs) trackB(~LenHs)]

	    NewTrain = {Append Ts Hs}

	    {Append Movs {FewFind NewTrain T}}
	 end
      end
   end
end

% Test
{Browse {FewFind [c a b] [c b a]}}

% Task 5
declare
fun {ApplyRules L}
   case L of nil then
      nil
   [] trackA(0)|T then
      {ApplyRules T}
   [] trackB(0)|T then
      {ApplyRules T}
   [] trackA(N)|trackA(M)|T then
      trackA(N+M)|{ApplyRules T}
   [] trackB(N)|trackB(M)|T then
      trackB(N+M)|{ApplyRules T}
   else
      L.1|{ApplyRules L.2}
   end
end

declare
fun {Compress Ms}
   Ns={ApplyRules Ms}
in
   if Ns==Ms then Ms else {Compress Ns} end
end

{Browse {Compress {Find [a b] [b a]}}}

% I did not manage to create a functioning implementation of Task 6