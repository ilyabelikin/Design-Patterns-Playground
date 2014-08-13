# Swift design playgrounds

I made this collection of playgrounds in the process of learning object oriented design course, so that I can understand concepts better in Swift instead of Java (which instructor used).

I suddenly finish course and realize, that I want to learn more, bridge basics I learnet to practice in Swift and keep this playgrounds updated. I will appreciate any help to made this collection complete and comprehensible.

Moreover I realize that Swift is an opportunity to reevalute some classical OO design patterns in light of functional approach. I will keep updating this collection updated on my way to learn what it practically means.


# Structure

I want to keep each playground resonable short and self explained. I keep "motivation" section and basic implementation in a playground file with pattern name, than more native for Swift or specific variants in additional playgrounds named by convention "Pattern name - Specific".  

**State Machine** is the best example so far.

# Materials

**Course:** [Object-Oriented Design with Simon Allardice](http://www.lynda.com/Programming-tutorials/Foundations-of-Programming-Object-Oriented-Design/96949-2.html)

**Course:** [Design Patterns with Elisabeth Robson and Eric Freeman](http://www.lynda.com/Developer-Programming-Foundations-tutorials/Foundations-Programming-Design-Patterns/135365-2.html)

**Blog post:** [Singleton Considered Stupid by Stevey Drunken](http://web.archive.org/web/20120221103151/http://sites.google.com/site/steveyegge2/singleton-considered-stupid)

"The problem is, about 1/3 to 1/2 of them were basically cover-ups for deficiencies in C++ that don't exist in other languages. Although I'm not a huge Perl fan anymore, I have to admit the Perl community caught on to this first (or at least funniest). They pointed out that many of these so-called patterns were actually an implementation of Functional Programming in C++. 

The Visitor, for instance, is just a class wrapper for a function with some accumulator variables, something that's achieved far more cleanly with, say, the map() function in higher-level languages. Iterator is a poor man's Visitor. The Strategy pattern is beautiful on the surface, but Strategy objects are typically stateless, which means they're really just first-order functions in disguise. (If they have state, then they're Closures in disguise.) Etc. You either get this, because you've done functional programming before, or you don't, in which case I sound like I'm a babbling idiot, so I guess I'll wrap it up."

TODO: Decompose second paragraph to actual examples in Swift

**Book:** [Head First Design Patterns](http://shop.oreilly.com/product/9780596007126.do)

TODO: Port all examples covered in the book (authors kindly argeed)

**Book:** [Functional Programming in Swift](http://www.objc.io/books/#early-access)

TODO: Understand what it really mean for mankind

# More Playgrounds

[Design Patterns implemented in Swift](https://github.com/ochococo/Design-Patterns-In-Swift) – another collection of patterns implementation. Without unrelated comments and awful spelling.
