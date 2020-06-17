/*

# Motivation

It looks like anyone who is experienced in functional programming feels the
urgent need to implement something like bind (>>=) Haskel operator in Swift
and see a Monad type in an Optional.

"A very common problem when dealing with optionals is dealing with multiple
ones. We quickly end up with a bunch of nested if-let statements that look 
very bad—especially since most of the time, the recovery from any one of 
them failing is the same."
http://nomothetis.svbtle.com/the-culmination-final-part

Bind operator provides a great utility to organize sequences of functions
with similar behavior. Extremely popular example to date is JSON parsing.

# Definition

Monad pattern is a combination of high ordered function and generic type 
which allows build piplines to process data structures of this type in
a cool way.

(Can you help me with a better definition?)

Monad is a class of types, which have one type parameter, and which follow
three Monads laws:

- There exists a function, by convention called lift: A -> M<A>, which
takes a non-monadic value a:A and wraps it in a monadic value M<A>.
- There exists a function, by convention called >>=, whith signature
(val:A, f:A -> M<B>) -> M<B>.

1. for any unwrapped value a:A and function f:A -> M<B>, 
lift(a) >>= f == f(a).
2. for any monadic value m:M<A>, m >>= return == m.
3. for any monadic value m:M<A>, and functions f:A -> M<B>, g:B -> M<C>, 
(m >>= f) >>= g == m >>= { x in f(x) >>= g }.


# Materials
Ordering is deliberate. I believe you will have an insight if you will 
read it in this one. At least it what I am trying to achive.

Parsing JSON in Swift: Safe and easy
http://chris.eidhof.nl/posts/json-parsing-in-swift.html

Functional JSON
http://owensd.io/2014/08/06/functional-json.html


Rob Napier's "“I wish there were a function that…" series:
http://robnapier.net/llama-calculus
http://robnapier.net/functional-wish-fulfillment
http://robnapier.net/maps

Alexandros Salazar's Monads series:
http://nomothetis.svbtle.com/error-handling-in-swift
http://nomothetis.svbtle.com/error-handling-in-swift-part-ii
http://nomothetis.svbtle.com/understanding-optional-chaining
http://nomothetis.svbtle.com/implicitly-unwrapped-optionals-in-depth
http://nomothetis.svbtle.com/the-culmination-i
http://nomothetis.svbtle.com/the-culmination-part-ii
http://nomothetis.svbtle.com/the-culmination-final-part

*/

// # Implementation
