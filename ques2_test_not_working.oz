
declare Stack Stmt Env StmtList SemStmt Handle InitStack InitStmt InitEnv PutOnStack POS

proc {InitStack X}
   X = nil
end

proc {InitStmt Y}
   Y = semStmt
end

proc {InitEnv Z}
   Z = environ()
end

Stack = {NewCell nil}

{InitStmt SemStmt}
{InitEnv Env}


StmtList = [ var ident(a)
							[ var ident(b)
								[ var ident(c) [nop][nop] ]
								[ var ident(d) [nop] ]
							]
							[ var ident(x) [nop]
							]
					]

POS = PutOnStack
proc {PutOnStack Env Stmt Stack}
   Stack := {List.append [SemStmt(Env Stmt)] (@Stack)}
end


{POS Env StmtList Stack}


proc {HandleHelper Stack}
		local GET  NEnv NStmt NStack NopHandle StmtHandle VarCreateHandle EqviClassKey SAStore AddClassKeyToSAStore Adduction in
				NStack = {NewCell nil}

				%%Pops the stack whenever called and returns the newstack, newEnv, newStatement
				proc {GET Stack}
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


				EqviClassKey = {Cell.new 1}
				SAStore = {Dictionary.new}

				fun {AddClassKeyToSAStore}
				   local Temp in
				      Temp = @EqviClassKey
				      %{Dictionary.put SAStore Temp eqvi(Temp)}
				      EqviClassKey := @EqviClassKey + 1
				      Temp
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

				proc {VarCreateHandle NStmt}
					 case NStmt of nil then skip
					 [][var ident(X) S] then
					 		{POS S NEnv  NStack}
							{HandleHelper NStack}
					 else
					 raise syntaxError(NStmt) end
					 end
				end

				proc {StmtHandle NStmt}
		       case NStmt of nil then skip
		       [](Stmt1|RstStmt)|Stmt2 then
						  case Stmt2 of nil then skip
						  else
						     {POS NEnv Stmt2 NStack}
						  end
						  {POS NEnv (Stmt1|RstStmt) NStack}
						  {HandleHelper NStack}
		       else
					 {VarCreateHandle NStack}
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
