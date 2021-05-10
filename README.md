# Automata Convertor
An NFA to DFA convertor written in dart.


## Input\Output Format

G =  (Q,T,$\delta$,$q_0$,F)

{Q}

{T}

$s_i \delta$矩阵

q0

{F}  

See documents.  

## How to
1. Run "dart compile exe" in project home directory, or run the configured Visual Studio Code Build task.
2. Prepare your NFA in the defined format. Store it in a nfa.csv file in the same directory as the compiled executable.
3. Run the executable and you will get the converted DFA in the defined format in the dfa.csv.