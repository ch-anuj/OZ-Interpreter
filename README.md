# Implementation:

#### Semantic Stack

 - Each element of the stack contain environment and the statement -> [env stmt]

#### Functions in the first question are:(Working)

1) GET-> for popping the stack which will return environment and the statement.

2) NopHandle -> for handling the [nop] statement.

3) StmtHandle -> for handling multiple statements like [[Stmt1] [Stmt2]..] etc

#### Functions in the Second question are:(Not Working: Error in Adduction operation)

4) VarCreateHandle -> this function will implement Adduction operation.

5) AddClassKeyToSAS -> for adding new keys to SAStore.


# REFERENCES

#### Idea of Stack Implementation is taken from this source (previous implementation)
1) https://github.com/ayushmi/OzInterpreter/blob/master/interpreter.oz

2) https://stackoverflow.com/
