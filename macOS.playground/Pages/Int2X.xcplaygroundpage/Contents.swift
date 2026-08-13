/*:
 [Previous: Interval](@previous)

 # Int2X -- fixed width, doubled recursively

 `Int2X<Word>` doubles the width of its `Word`, so the family is built
 by recursion: `Int128 = Int2X<UInt64>`, `Int256 = Int2X<UInt128>`,
 ... up to `Int1024`.  Fixed width means fixed cost: no heap, and
 overflow traps like `Int`'s would.
 */
import PONS
Int128.max                      // 2^127 - 1
UInt1024.max                    // 2^1024 - 1
//: ## Where Int64 gives up
let f92 = 7540113804746346429 as Int64      // fib(92), Int64's last Fibonacci
// fib(93) would trap; Int128 has room for fib(184)
func fib<T:BinaryInteger>(_ n:T)->T {
    return n < 2 ? n: (2...Int(n)).reduce((T(0), T(1))){
        (p, _) in (p.1, p.0 + p.1)
    }.1
}
fib(184 as Int128)
fib(1476 as Int1024)            // and Int1024, fib(1476)
func fact<T:BinaryInteger>(_ n:T)->T {
    return n < 1 ? 1 : (1...Int(n)).map{ T($0) }.reduce(T(1), *)
}
fact(33 as Int128)              // 33! is the largest factorial in 128 bits
fact(170 as Int1024)            // 170! -- Double.infinity territory
//: ## Rational over Int2X -- exact fractions without the heap
let q = Int1024(1).over(7)
q + Int1024(2).over(7)          // exactly 3/7
let milü = Int128(355).over(113)
milü.toDouble()                 // 密率, good to 6 places
//: ## They are honorary members of the number-theory club, too
(Int128(1) << 127 - 1).isPrime  // the Mersenne prime again, no BigInt needed
//:
//: [Next: Generic Programming](@next)
