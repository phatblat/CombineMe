import Foundation
import Combine

/*:
 # Publishers and Subscribers
 - A Publisher _publishes_ values ...
 - .. a subscriber _subscribes_ to receive publisher's values

 __Specifics__:
 - Publishers are _typed_ to the data and error types they can emit
 - A publisher can emit, zero, one or more values and terminate gracefully or with an error of the type it declared.
 */

/*:
## Example 1
"publish" just one value then complete
 */
/**
 ## <Type><Error>
 <type = Int>, <Error = None>
 */
let publisher1 = Just(42)

// You need to _subscribe_ to receive values (here using a sink with a closure)
let subscription1 = publisher1.sink { value in
	print("Received value from publisher1: \(value)")
}

/*:
## Example 2
"publish" a series of values immediately
 */
//<Int> < Never>
let publisher2 = [1,2,3,4,5].publisher

//<Int> <Never>
let subscription2 = publisher2
    //.map{Int($0)}
    .sink {value in
        print("Received value from publisher2: \(value + 12)")
    }

//<Int> < Never>
let publisher_string = ["1", "2"].publisher

//<Int> <Never>
let subscription3 = publisher_string
    .map{Int($0)}
    .sink {value in
        print("Received value from publisher2: \(value! + 12)")
    }

// On collection vs Publisher
let coolect = [1,2,3,4,5]
let col2 = coolect.map{$0 * 2 }
print(col2)

/*:
## Example 3
assign publisher values to a property on an object
 */
print("")
class MyClass {
	var property: Int = 0 {
		didSet {
			print("Did set property to \(property)")
		}
	}
}

let object = MyClass()
let subscription4 = publisher2.assign(to: \.property, on: object)

//: [Next](@next)
