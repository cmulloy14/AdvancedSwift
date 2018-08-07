import UIKit

// Generics
// The goal of generic programming is to express the essential interface an algorithm or data structure requires
//It is similar to overlaoding, in that one funciton name handles multiple implementations

// Overload example
func raise(_ base: Double, to exponent: Double) -> Double {
    return pow(base, exponent)
}

func raise(_ base: Float, to exponent: Float) -> Float {
    return powf(base, exponent)
}

// Swift picks the least generic method 
// For example, if the same method takes a UIView or a UILabel, Swift would take the label 

func log(_ view: UIView) {
    print("Its a view")
}

func log(_ view: UILabel) {
    print("Its a label with text \(view.text)")
}


let label = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
label.text = "Im a label"
log(label)

let button = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
log(button)


// Overloads are resolved statically, so the compiler bases its decision of which overload to call on the static types of variables involved
// So in an Array of views, the compiler will choose the more geniric UIView implementation
let views = [label, button]
views.forEach {
    log($0)
}




