I initially implemented stack functions by creating an extension on Array like
this:

extension Array {
    mutating func push(item: T) {
        append(item)
    }

    mutating func pop() -> T? {
        return (count > 0 ? removeLast() : nil)
    }

    func peek() -> T? {
        return (count > 0 ? self[count-1] : nil)
    }
}

The problem I encountered is a general problem of Array being implemented as a
Struct instead of a class, which means it's passed by value instead of by
reference. So doing the following becomes a problem:

var stackA, stackB, stackC: Array<Int>
var board = [stackA, stackB, stackC]

The board variable received a copy of the stackX variables. When the size of
any of the arrays changes, the arrays referenced by board are copied. The fact
that this doesn't happen until a mutation occurs complicates working with
arrays even more in Swift.

My solution was to create a Stack class which implements an internal array,
thus all Stack objects are passed by reference which is how most OO programmers
are used to working with arrays.
