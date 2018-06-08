#if os(Linux)
import Glibc
#else
import Darwin
#endif

//
// library versions. may not agree with Complex.func(x+0.0.i).real
//
extension FloatingPointMath {
    #if os(Linux)
    public static func erf   (_ x:Self)->Self { return Self(Glibc.erf  (x.asDouble)) }
    public static func erfc  (_ x:Self)->Self { return Self(Glibc.erfc (x.asDouble)) }
    public static func lgamma(_ x:Self)->Self { return Self(Glibc.lgamma(x.asDouble)) }
    public static func tgamma(_ x:Self)->Self { return Self(Glibc.tgamma(x.asDouble)) }
    #else
    public static func erf   (_ x:Self)->Self { return Self(Darwin.erf  (x.asDouble)) }
    public static func erfc  (_ x:Self)->Self { return Self(Darwin.erfc (x.asDouble)) }
    public static func lgamma(_ x:Self)->Self { return Self(Darwin.lgamma(x.asDouble)) }
    public static func tgamma(_ x:Self)->Self { return Self(Darwin.tgamma(x.asDouble)) }
    #endif
}
extension Double {
    #if os(Linux)
    public static func erf  (_ x:Double)->Double { return Glibc.erf(x) }
    public static func erfc (_ x:Double)->Double { return Glibc.erfc(x) }
    public static func lgamma(_ x:Double)->Double { return Glibc.lgamma(x) }
    public static func tgamma(_ x:Double)->Double { return Glibc.tgamma(x) }
    #else
    public static func erf  (_ x:Double)->Double { return Darwin.erf(x) }
    public static func erfc (_ x:Double)->Double { return Darwin.erfc(x) }
    public static func lgamma(_ x:Double)->Double { return Darwin.lgamma(x) }
    public static func tgamma(_ x:Double)->Double { return Darwin.tgamma(x) }
    #endif
}

// placeholder
extension PONS {
    /// factorial
    public static func factorial(_ n:Int)->BigInt {
        return n < 1 ? BigInt(1) : (1 ... n).map { BigInt($0) }.reduce(BigInt(1), *)
    }
    /// binominal coefficient of `x` and `y`
    public static func binominalCoefficient(_ x:BigInt, _ y:BigInt)->BigInt {
        var (n, k) = x < y ? (y, x) : (x, y)
        if n < 2*k  { k = n - k }
        if k == 0   { return 1 }
        let u = ((n-k+1)...n).reduce(1, *)
        let v = (1...k).reduce(1, *)
        return u / v
    }
    private static var bernoulliNumbers = [BigRat(1), -BigRat(1, 2)]
    /// Bernoulli number of `n`
    public static func bernoulliNumber(_ n : Int)->BigRat {
        if n < bernoulliNumbers.count { return bernoulliNumbers[n] }
        var b = BigRat(0)
        if n & 1 == 0 {
            for k in 0...n-1 {
                b += binominalCoefficient(BigInt(n+1), BigInt(k)) * bernoulliNumber(k)
            }
            b /= -BigRat(n + 1)
        }
        bernoulliNumbers.append(b)
        return b
    }
}

extension ComplexFloat where Element == BigRat {
     //
    // cf. http://algolist.manual.ru/maths/count_fast/gamma_function.php
    //
    /// lnΓ(x)
    public static func lgamma(_ z:Self, precision px:Int = 64, debug:Bool = false)->Self   {
        if z.real.isNaN  || z.imag.isNaN     { return Self(real:Element.nan, imag:Element.nan) }
        if z.real.isZero && z.imag.isZero    { return 1/z }
        if z.real.isInfinite || z.imag.isInfinite { return Self(+Element.infinity) }
        if z == Self(1) || z == Self(2)      { return Self(0) }
        let pi = Element.PI(precision:px*2)
        if z.real.sign == .minus {
            let lgmx  = lgamma(-z, precision:px*2, debug:debug)
            if debug { print("lgamma(\(-z)) =", lgmx) }
            let sinpi = sin(pi * -z, precision:px*2)
            let r = log(pi, precision:px*2) - log(-z, precision:px*2)
                - lgmx
                - log(sinpi, precision:px*2)
            return px < 0 ? r : r.truncated(width: px)
        }
        let bias = Element(8)
        var (u, v) = (z, Self(1))
        while u.real.magnitude < bias {
            v *= u; u += 1;
        }
        if debug { print("(z, u, v) = ", z, u, v) }
        var r = (u - 0.5) * log(u, precision:px*2)
        r += -u
        r += +log(2*pi, precision:px*2)/2
        r += -log(v, precision:px*2)
        if debug { print(0, 0, (r.real.asDouble, r.imag.asDouble)) }
        let epsilon = Element(BigInt(1)) / Element(BigInt(1) << px.magnitude)
        let x2 = u * u
        var d = u
        for i in 1...px.magnitude * 2 {
            if i & 1 == 1 { continue }
            let n = Self(PONS.bernoulliNumber(Int(i)) / BigRat(i * (i-1)))
            if debug { print(i, n, (r.real.asDouble, r.imag.asDouble)) }
            let t = n / d
            r += t
            r.truncate(width:px*2)
            if t.magnitude < epsilon { break }
            d *= x2
            d.truncate(width:px*2)
        }
        return px < 0 ? r : r.truncated(width: px)
    }
    /// Γ(x)
    public static func tgamma(_ z:Self, precision px:Int = 64)->Self   {
        return exp(lgamma(z, precision:px*2), precision:px*2)
    }
}

extension ComplexFloat where Element == Double {
    public static func tgamma(_ z:Self)->Self {
        return Self(Complex.tgamma(Complex(real:z.real.asBigRat, imag:z.imag.asBigRat)))
    }
    public static func lgamma(_ z:Self)->Self {
        return Self(Complex.lgamma(Complex(real:z.real.asBigRat, imag:z.imag.asBigRat)))
    }
}

extension RationalType {
    /// lnΓ(x)
    public static func lgamma(_ x:Self, precision px:Int = 64, debug:Bool = false)->Self   {
        if x.isNaN      { return nan }
        if x.isZero     { return 1/x }
        if x.isInfinite { return +infinity }
        if x == 1       { return 0 }
        if let u = x as? BigRat {
            let (ix, fx) = u.asMixed
            if fx.isZero && 0 < ix {
                print("\(Self.self).lgamma: Γ(\(ix)) = (\(ix) - 1)!")
                return log(tgamma(Self(ix), debug:debug), precision:px)
            }
        }
        return Self(Complex.lgamma(x.asBigRat + BigRat(0.0).i, precision:px, debug:debug).real)
    }
    /// Γ(x)
    public static func tgamma(_ x:Self, precision px:Int = 64, debug:Bool = false)->Self   {
        if let u = x as? BigRat {
            let (ix, fx) = u.asMixed
            if fx.isZero && 0 < ix {
                print("\(#line): Γ(\(ix)) = (\(ix) - 1)!")
                return Self(PONS.factorial(Int(ix) - 1))
            }
        }
        return exp(lgamma(x, precision:px*2, debug:debug), precision:px*2)
    }
}
