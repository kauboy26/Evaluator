# Evaluator

## About
This thing evaluates assignment statements. To clarify further, here's an
example (taken straight from the file "sample.txt"):  
```
a = 15 + 1 * 5  
b = a * 2  
c = 19 + 1 + b + a  
9 * 9
c * 2
7
a
```

After the first statement is executed, the value of the expression on the right
is stored into "a". Effectively, a = 20. In the next statement, b = a * 2 =
15 * 2 = 30.  

You can also feed in expressions that don't assign any value to a variable, such
as "9 * 9" (the console will print "81"), "c * 2" (in this case, 80), etc.

## Usage

You need bison, the parser-generator, installed. Run (in the directory
containing the file runscript.sh)  
```
./runscript
``` 
to produce the parser generator and also run the executable. Alternatively, you
can copy paste the commands contained within the file runscript.sh into your
terminal.  

To run the executable once it has been built, simply run  
```
./madudes
```
You can type whatever you want into ```stdin```. You can feed the sample file in
with  
```
cat sample.txt | ./madudes
```

## Restrictions

Only use single character, lower-case variable names. Therefore, you can have
at most 26 variables.