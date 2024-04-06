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

```swift
import Rhapsody

let f = { (x: Int) in x + 1 }
let g = { (x: Int) in x * 2 }

// compose
let h = f <> g
print(h(1)) // 3
```


