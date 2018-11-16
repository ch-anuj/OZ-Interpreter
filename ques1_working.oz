
declare Stack Stmt Env StmtList SemStmt Handle EmptyStack EmptyStmt EmptyEnv PutOnStack POS

StmtList = [
	    [first]
	    [
	     [second]
	     [
	      [third][fourth]
	     ]
	     [fifth]
	    ]
	    [sixth]
	   ]

proc {EmptyStack X}
   X = nil
end

proc {EmptyStmt Y}
   Y = semStmt
end

proc {EmptyEnv Z}
   Z = env
end

Stack = {NewCell nil}

{EmptyStmt SemStmt}
{EmptyEnv Env}

POS = PutOnStack

proc {PutOnStack Stmt Env Stack}
   Stack := {List.append [SemStmt(Env Stmt)] (@Stack)}
end

{POS StmtList Env Stack}

%%%% Attempting for question 1, by handelling the [nop]* statements

proc {Handle Stack}
   local HandleHelper  in
      proc {HandleHelper Stack}
	 local GET  NEnv NStmt NStack NopHandle StmtHandle in
	    NStack = {NewCell nil}
	    proc {GET Stack}%%Pops the stack whenever called and returns the newstack, newEnv, newStatement
	       case @Stack
	       of nil then
		  NStmt = nil
		  NEnv = nil
	       else
		  NStmt = (@Stack).1.2
		  NEnv = (@Stack).1.1
		  NStack := (@Stack).2
	       end
	    end


	    proc {NopHandle NStmt}
	       case NStmt
	       of nil then skip
	       []nop|nil then
		  {HandleHelper NStack}
	       else
		  {StmtHandle NStmt}
	       end
	    end

	    proc {StmtHandle NStmt}
	       case NStmt of nil then skip
	       []Stmt1|Stmt2 then
		  case Stmt2 of nil then skip
		  else
		     {POS Stmt2 Env NStack}
		  end
		  {POS Stmt1 Env NStack}
		  {HandleHelper NStack}
	       else
		  {HandleHelper NStack}
	       end
	    end

	    {GET Stack}
	    {Browse @NStack}
	    {Browse NStmt}
	    {Browse NEnv}
	    {Browse oneCompleted}
	    {NopHandle NStmt}
	 end
      end
      {HandleHelper Stack}
   end
end



{Handle Stack}
