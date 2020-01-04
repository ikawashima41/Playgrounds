import XCTest

// Liner pattern

func linearSearch<T: Equatable>(_ array: [T], _ object: T) -> Int? {
  for (index, obj) in array.enumerated() where obj == object {
    return index
  }
  return nil
}

let array = [5, 2, 4, 7]
linearSearch(array, 7)

// stack pattern

public struct Stack<T> {
    fileprivate var array = [T]()

    public var isEmpty: Bool {
        return array.isEmpty
    }

    public var count: Int {
        return array.count
    }

    public mutating func push(_ elemnet: T) {
        array.append(elemnet)
    }

    public mutating func pop() -> T? {
        return array.popLast()
    }

    public var top: T? {
        return array.last
    }
}

extension Stack: Sequence {
  public func makeIterator() -> AnyIterator<T> {
    var curr = self
    return AnyIterator {
      return curr.pop()
    }
  }
}

var stackOfNames = Stack(array: ["111", "222", "333"])

stackOfNames.push("444")

stackOfNames.pop()

stackOfNames.top

stackOfNames.isEmpty


// Queue

public struct Queue<T> {
  fileprivate var array = [T]()

  public var isEmpty: Bool {
    return array.isEmpty
  }

  public var count: Int {
    return array.count
  }

  public mutating func enqueue(_ element: T) {
    array.append(element)
  }

  public mutating func dequeue() -> T? {
    if isEmpty {
      return nil
    } else {
      return array.removeFirst()
    }
  }

  public var front: T? {
    return array.first
  }
}

extension Array {
    subscript(guarded idx: Int) -> Element? {
        guard (startIndex..<endIndex).contains(idx) else {
            return nil
        }
        return self[idx]
    }
}

var queueOfNames = Queue(array: ["Carl", "Lisa", "Stephanie", "Jeff", "Wade"])

// Adds an element to the end of the queue.
queueOfNames.enqueue("Mike")

// Queue is now ["Carl", "Lisa", "Stephanie", "Jeff", "Wade", "Mike"]
print(queueOfNames.array)

// Remove and return the first element in the queue. This returns "Carl".
queueOfNames.dequeue()

// Return the first element in the queue.
// Returns "Lisa" since "Carl" was dequeued on the previous line.
queueOfNames.front

// Check to see if the queue is empty.
// Returns "false" since the queue still has elements in it.
queueOfNames.isEmpty


//　Insertion Sort

/// Performs the Insertion sort algorithm to a given array
///
/// - Parameters:
///   - array: the array of elements to be sorted
///   - isOrderedBefore: returns true if the elements provided are in the corect order
/// - Returns: a sorted array containing the same elements
func insertionSort<T>(_ array: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
  guard array.count > 1 else { return array }

  var a = array
  for x in 1..<a.count {
    var y = x
    let temp = a[y]
    while y > 0 && isOrderedBefore(temp, a[y - 1]) {
      a[y] = a[y - 1]
      y -= 1
    }
    a[y] = temp
  }
  return a
}

/// Performs the Insertion sort algorithm to a given array
///
/// - Parameter array: the array to be sorted, containing elements that conform to the Comparable protocol
/// - Returns: a sorted array containing the same elements
func insertionSort<T: Comparable>(_ array: [T]) -> [T] {
    guard array.count > 1 else { return array }

    var a = array
    for x in 1..<a.count {
        var y = x
        let temp = a[y]
        while y > 0 && temp < a[y - 1] {
            a[y] = a[y - 1]
            y -= 1
        }
        a[y] = temp
    }
    return a
}

let list = [ 10, -1, 3, 9, 2, 27, 8, 5, 1, 3, 0, 26 ]
print(insertionSort(list))
print(insertionSort(list, <))
print(insertionSort(list, >))

func testtest(value: Test) {
    let value: String = value.string == nil ? "optional" : value.string ?? ""
    print(value)
}

enum Test {
    case aaa
    case bbb

    var string: String? {
        switch self {
        case .aaa:
            return "aaa"
        default:
            return nil
        }
    }
}

testtest(value: .bbb)
