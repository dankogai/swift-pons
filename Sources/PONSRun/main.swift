import PONS

let bq = BigRat(42)
let cq = bq + bq.i
print( Complex.sqrt(cq) )
let bf = BigFloat(42)
let cf = bf + bf.i
print( Complex.sqrt(cf) )

print( BigFloat.lgamma(bf, precision:64) )
print( Complex.lgamma (cf, precision:64) )


let ibq = Interval(BigRat(-1.0.ulp),BigRat(+1.0.ulp) )
print(ibq/ibq)

func det<T:IntervalElement>(a:Interval<T>, b:Interval<T>, c:Interval<T>)->Interval<T> {
    return Interval<T>.sqrt(b*b - T(4)*a*c)
}

let a = Interval(BigFloat(1.0-1.0.ulp), BigFloat(1.0+1.0.ulp))
let b = Interval(BigFloat(1e15-1e15.ulp), BigFloat(1e15+1e15.ulp))
let c = Interval(BigFloat(1e14-1e14.ulp), BigFloat(1e14+1e14.ulp))
let x = (-b + det(a:a,b:b,c:c)) / (BigFloat(2) * a)
let y = BigFloat(2) * c / (-b - det(a:a,b:b,c:c))
print(x, x.avg.asDouble, x.err.asDouble)
print(y, y.avg.asDouble, y.err.asDouble)

//print( BigRat.lgamma(BigRat(1.0/Double.greatestFiniteMagnitude), precision:64, debug:true).asDouble )
