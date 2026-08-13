/*:
 [Previous: Complex](@previous)

 # Interval -- arithmetic with guaranteed brackets

 `a ± r` is the interval `[a-r, a+r]`; every operation returns an
 interval guaranteed to contain the true result.
 */
import PONS
//: ## The ± operator (spell it +- if your keyboard objects)
let iv = 1.0 ± 0.001
iv.min
iv.max
let same = 1.0 +- 0.001     // the ASCII twin
//: ## Operations bracket the truth
let r2 = Interval.sqrt(2.0 ± 0.001)
r2.min < 2.0.squareRoot()
2.0.squareRoot() < r2.max
(iv * iv).max               // ≥ the true square, always
//: ## Any IntervalElement will do -- BigFloat and BigRat included
let tight = Interval.sqrt(BigFloat(2) ± BigFloat(2) ** -100)
tight.min < BigFloat.sqrt(BigFloat(2))
BigFloat.sqrt(BigFloat(2)) < tight.max
//: With `BigRat` endpoints the interval arithmetic itself is exact:
let r = BigRat(1) ± BigRat(1, 128)
(r * r).min.toString()      // exactly (127/128)^2
(r * r).max.toString()      // exactly (129/128)^2
//:
//: [Next: Int2X](@next)
