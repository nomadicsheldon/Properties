import UIKit

// Stored Properties
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)

// the range represents integer values 0,1, and 2
rangeOfThreeItems.firstValue = 6
// the range now represents integer values 6,7, and 8
// length can't be change because it's a constant property

// Stored Properties of constant Structure Instances
let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
//rangeOfFourItems.firstValue = 3

//-------------------------------------------------------------------------------------------------------------------------//

// Lazy Stored Properties
// A Lazy property is a property whose initital value is not calculated until the first time it is used.
// Lazy property can't be assign as Let
// 1. Lazy properties are useful when the initial value for a property is dependent on the outside factors whose values are not known until after an instance's initialization is completed.
// 2. Lazy properties are also useful when the initial value for a property requires complex or computationally expensive setup that should not be performed unless or until it is needed.

class DataImporter {
    /*
     DataImporter is a class to import data from an external file.
     The class is assumed to take a nontrivial amount of time to initialize.
     */
    var filename = "data.txt"
    // the DataImporter class would provide data importing functionality here
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    // the DataManager class would provide data management functionality here
}

let manager = DataManager()
manager.data.append("some data")
manager.data.append("some more data")
// the DataImporter instance for the importer property has not yet been created

print(manager.importer.filename)
// the DataImporter instance for the importer property has now been created
// Prints "data.txt"

//-------------------------------------------------------------------------------------------------------------------------//

// Computed Properties -

// Classes, structure, and enumerations can define computed properties, which do not actually store a value. Instead, they provide a getter and an optional setter to retrieve and set other properties and values indirectly.

struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width/2)
            let centerY = origin.y + (size.height/2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width/2)
            origin.y = newCenter.y - (size.height/2)
        }
    }
}

var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at \(square.origin.x), \(square.origin.y)")

//-------------------------------------------------------------------------------------------------------------------------//

// Shorthand Setter Declaration

// If a computed property's setter doesn't define a name for the new value to be set, a default name of newValue is used.

struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width/2)
            let centerY = origin.y + (size.height/2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width/2)
            origin.y = newValue.y - (size.height/2)
        }
    }
}

//-------------------------------------------------------------------------------------------------------------------------//

// Shorthand Setter Declaration

// If the entire body of a getter is a single expression, the getter implicitly returns that expression.

struct CompactRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            return Point(x: origin.x + (size.width/2), y: origin.y + (size.height/2))
        }
        set {
            origin.x = newValue.x - (size.width/2)
            origin.y = newValue.y - (size.height/2)
        }
    }
}

//-------------------------------------------------------------------------------------------------------------------------//

// Read only computed property

struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width*height*depth
    }
}

// Always define Read only computed as var because their value is not fixed. The let keyword is only used for constant properties, to indicate that their values cannot be changed once they are set as part of instance initialization.

let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)

print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")

//-------------------------------------------------------------------------------------------------------------------------//

// Property Observers


class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("about to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue {
                print("added \(totalSteps - oldValue) steps")
            }
        }
    }
}

// we can not give observer to lazy property
// if previous assigned value is same as current value then didSet is not getting called, try this out if i am wrong.

let stepCounter = StepCounter()
stepCounter.totalSteps = 200
// About to set totalSteps to 200
// Added 200 steps
stepCounter.totalSteps = 360
// About to set totalSteps to 360
// Added 160 steps
stepCounter.totalSteps = 896
// About to set totalSteps to 896
// added 536 steps

//-------------------------------------------------------------------------------------------------------------------------//

// Property Wrappers

// go through swift documentation

@propertyWrapper
struct TwelveOrLess {
    private var number: Int
    init() {
        self.number = 0
    }
    var wrappedValue: Int {
        get {
            return number
        }
        set {
            number = min(newValue, 12)
        }
    }
}

struct SmallRectangle1 {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}

var rectangle = SmallRectangle1()
print(rectangle.height)
// Prints "0"
rectangle.height = 10
print(rectangle.height)
// Prints "10"
rectangle.height = 24
print(rectangle.height)
// Prints "12"

//-------------------------------------------------------------------------------------------------------------------------//

// Type property syntax

struct SomeStructure {
    static var storedTypeProperty = "Some Value."
    static var computedTypeProperty: Int {
        return 1
    }
}

enum SomeEnumuration {
    static var storedTypeProperty = "some Value."
    static var computedTypeProperty: Int {
        return 6
    }
}

class SomeClass {
    static var storedTypeProperty = "Some Value."
    static var computedTypeProperty: Int {
        27
    }
    class var overridableComputedTypeProperty: Int {
        return 107
    }
}

let someClass = SomeClass()


