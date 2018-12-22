# SortedCollection

## Motivation

SortedCollection contains implementations of binary search with the purpose of finding the best API, eventually leading to a Swift Language Proposal.

## Summary

SortedCollection contains implementations of four search methods:

- `lowerBound(of:)` / `lowerBound(of:in:)` for finding the **lower bound** of a value.
- `upperBound(of:)` / `upperBound(of:in:)` for finding the **upper bound** of a value.
- `firstIndex(of:)` / `firstIndex(of:in:)` for finding the **first index** of a value.
- `range(of:)` / `range(of:in:)` for finding the **range** of a value.

## Example

```swift
let sortedBase = Array(0..<1_000_000)
let haystack = SortedCollection(sorted: sortedBase)
let needle = 42

let lowerBound = haystack.lowerBound(of: needle)
let upperBound = haystack.upperBound(of: needle)
let firstIndex = haystack.firstIndex(of: needle)
let range = haystack.range(of: needle)
```

## Contribution

Please feel free to provide **ideas for improvements**, **alternatives** or general critique through either [Issues](https://github.com/regexident/SortedCollection/issues) or [Pull Requests](https://github.com/regexident/SortedCollection/pulls).
