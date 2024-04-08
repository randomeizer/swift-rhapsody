# swift-rhapsody

This is a fairly simple Swift wrapper that adds operator support to `pointfreeco`'s [swift-overture](https://github.com/pointfreeco/swift-overture) library.

Its operators are inspired by their [swift-prelude](https://github.com/pointfreeco/swift-prelude) library.

## Installation

### Swift Package Manager

Add the following to the `dependencies` section of your `Package.swift` file:

```swift
.package(url: "https://github.com/randomeizer/swift-rhapsody.git", from: "0.5.0")
```

Then add `Rhapsody` as a dependency for your target:

```swift
.target(name: "YourTarget", dependencies: [
  .product(name: "Rhapsody", package: "swift-rhapsody"),
])
```

## Usage

Rhapsody exports the `Overture` library, so you can simply replace `Overture` with `Rhapsody` in your code.

Let's say we have three basic functions:

```swift
let increment = { (x: Int) in x + 1 }
let double = { (x: Int) in x * 2 }
let decrement = { (x: Int) in x - 1 }
```

We can forward-compose them using the `>>>` operator:

```swift
import Rhapsody

// forward-compose
let h = increment >>> double
let i = h >>> decrement
print(h(1)) // 4
print(i(1)) // 3
```

You can use any standard `Overture` functions in the same way:

```swift
import Rhapsody

let h = pipe(increment, double)
print(h(1)) // 4
```

Or, combine a series of operators:

```swift
import Rhapsody

let j = 1 |> increment >>> double >>> decrement
print(j) // 3
```

Or, combine `Overture` functions and `Rhapsody` operators:

```swift
import Rhapsody

let add = { (x: Int, y: Int) in x + y }

// forward-compose
let h = curry(add)(5) >>> double
```

## Documentation

The library exports the following operators:

### >>> (Forward Composition)

This operator chains two functions together where the output of the first function is the input of the second function.

```swift
let f = { (x: Int) in x + 1 }
let g = { (x: Int) in "\(x)!" }

let h = f >>> g
print(h(1)) // "2!"
```

### <<< (Backward Composition)

This operator chains two functions together where the output of the second function is the input of the first function.

```swift
let f = { (x: Int) in x + 1 }
let g = { (x: Int) in "\(x)!" }

let h = g <<< f
print(h(1)) // "2!"
```

### <> (Concatenation)

There are a couple of variations of this operator. The essentially
chains functions where the input and output types are the same.

```swift
let f = { (x: Int) in x + 1 }
let g = { (x: Int) in x * 2 }

let h = f <> g
print(h(1)) // 4
```

The second variation is for functions that take an `inout` parameter and return `Void`:

```swift
var x = 1
let f = { (x: inout Int) in x += 1 }
let g = { (x: inout Int) in x *= 2 }

let h = f <> g
h(&x)
print(x) // 4
```

The third variation is for functions that take a single reference type parameter and return `Void`:

```swift
final class Box<A> {
  var value: A
  init(_ value: A) {
    self.value = value
  }
}

let f = { (box: Box<Int>) in box.value += 1 }
let g = { (box: Box<Int>) in box.value *= 2 }

let h = f <> g
let box = Box(1)
h(box)
print(box.value) // 4
```

### |> (Pipe Forward)

There are a few variations of this operator. The first takes the left-hand side and passes it as the input to the right-hand side, returning the result:

```swift
let f = { (x: Int) in x + 1 }

let result = 1 |> f
print(result) // 2
```

The second variation is for functions that take an `inout` parameter and return `Void`:

```swift
var x = 1
let f = { (x: inout Int) in x += 1 }

x |> f
print(x) // 2
```

The third variation is for functions that take a single reference type parameter and return `Void`:

```swift
final class Box<A> {
  var value: A
  init(_ value: A) {
    self.value = value
  }
}

let f = { (box: Box<Int>) in box.value += 1 }

let box = Box(1)
box |> f
print(box.value) // 2
```
