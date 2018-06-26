//: [Previous](@previous)

import PONS // That's all it takes to get…

var bi = BigInt(1) << 1024 - 1          // BigInt
var bq = BigInt(1).over(BigInt(2))      // BigRat
bq = BigRat.sqrt(bq)                    // and Its math functions
var bf = BigFloat(bq)                   // and BigFloat
BigFloat.acos(bf)                       // and Its math functions, too
var cd  = Complex.sqrt(-1.0)            // and Complex<Double>
let pi128 = BigFloat.PI(precision:128)
var cbf = Complex.exp(pi128.i)          // and Complex<BigFloat>
// and more!

func fib<T:BinaryInteger>(_ n:T)->T {
    return n < 2 ? n: (2...Int(n)).reduce((T(0), T(1))){
        (p, _) in (p.1, p.0 + p.1)
    }.1
}

let F11  = fib(11 as Int8)
let F13  = fib(13 as UInt8)
let F23  = fib(23 as Int16)
let F24  = fib(24 as UInt16)
let F46  = fib(46 as Int32)
let F47  = fib(47 as UInt32)
let F92  = fib(92 as Int64)
let F93  = fib(93 as UInt64)
let F666 = fib(666 as BigInt)

func fact<T:BinaryInteger>(_ n:T)->T {
    return n < 1 ? 1 : (1...Int(n)).map{ T($0) }.reduce(T(1), *)
}


//: [Next](@next)
