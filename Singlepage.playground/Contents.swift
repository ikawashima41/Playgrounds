//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

final class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        view.addSubview(label)
        self.view = view

        self.view.backgroundColor = .red
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()

typealias Closure<T> = (T) -> T

struct PluginCollection<Value> {
    private var closure = [Closure<Value>]()

    mutating func add(_ plugin: @escaping Closure<Value>) {
        closure.append(plugin)
    }
    func apply(to value: Value) -> Value {
        closure.reduce(value) { value, closure in
            closure(value)
        }
    }
}


struct Request {
    var params: String
}

var pre = PluginCollection<Request>()
var post = PluginCollection<Result<UIImage, Error>>()


// requestを実行するクロージャー作成
let request = pre.apply(
    to: Request(params: "Test")
)




post.add { req in
    switch req {
    case .success(let image):
        print(image)
        return req
    case .failure(let err):
        print(err)
        return req
    }
}


public protocol Plugin: AnyObject {
    associatedtype Object: AnyObject

    func activate(for object: String, in game: String)
    func deactivate()
}



/// next
struct ImageTransform {
    let closure: (UIImage) throws -> UIImage

    // unneccesary
    func apply(to image: UIImage) throws -> UIImage {
        try closure(image)
    }
}

extension ImageTransform {
    static var contrastBoost: Self {
        ImageTransform { image in
            return image
        }
    }

    static func portrait(withZoomMultipler multiplier: Double) -> Self {
        ImageTransform { image in
            return image
        }
    }
}

struct ImageFilter {
    var name: String
    var icon: String
    var transforms: [ImageTransform]
}

extension ImageFilter {
    static var dramatic: Self {
    ImageFilter(
        name: "Dramatic",
        icon: "icon",
        transforms: [
            .portrait(withZoomMultipler: 2.1),
            .contrastBoost
        ])
    }
}

let dramaticFilter = ImageFilter(
    name: "Dramatic",
    icon: "icon",
    transforms: [
        .portrait(withZoomMultipler: 2.1),
        .contrastBoost,
    ]
)

let filter = ImageFilter.dramatic

/// Struct & enum


struct DrawingContext {
    func move(to: Any) {

    }
    func drawLine(to: Any? = nil) {
    }

    func makeImage() -> UIImage {
        return UIImage()
    }
}

struct Point {
    func movedBy(x: Any? = nil, y: Any? = nil) {
        // dummy method
    }
}
struct Shape {
    var drawing: (inout DrawingContext) -> Void
}



extension Shape {
    static func square(at point: Point, sideLength: Double) -> Self {
        Shape { context in
            let origin = point.movedBy(
                x: -sideLength / 2,
                y: -sideLength / 2
            )

            context.move(to: origin)
            context.drawLine(to: origin)
        }
    }

    static func circle(at point: Point, sideLength: Double) -> Self {
        Shape { context in
            let origin = point.movedBy(
                x: -sideLength / 2,
                y: -sideLength / 2
            )

            context.move(to: origin)
            context.drawLine(to: origin)
        }
    }
}

// making variable
func draw(_ shapes: Shape...) -> UIImage {
    var context = DrawingContext()

    shapes.forEach { shape in
        context.move(to: "")
        shape.drawing(&context)
    }

    return context.makeImage()
}

let image = draw(
    .circle(at: Point(), sideLength: 10),
    .square(at: Point(), sideLength: 5)
)

let array = [3, 9, 1, 4, 6, 2]
let sorted = array.sorted(by: >)

enum UnboxPath {
    case key(String)
    case keyPath(String)
}

struct UserSchema {
    static let name = key("name")
    static let age = key("age")
    static let posts = key("posts")

    private static let key = UnboxPath.key
}

UserSchema.name

func call<Input, Output>(_ function: (Input) -> Output, with input: Input) -> Output {
    return function(input)
}


zip(["aaa", "bbb"], ["bbb", "aaa"]).forEach {
    if $0 != $1 {
        print("success")
    }
}

typealias Pair<T> = (T, T)

var storeId = "store"
var distance = "distance"
var value = "\(distance)"

let pattern = "/[A-Za-z0-9]+"

let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)

if let result: NSTextCheckingResult = regex?.firstMatch(in: value, options: [], range: NSMakeRange(0, value.count)) {
    if let range = Range(result.range(at: 0), in: value) {
        let store = value[range]
        let distance = value.replacingOccurrences(of: store, with: "")
        let storeId = store.replacingOccurrences(of: "/", with: "")
        print(distance)
        print(storeId)
    } else {
        print("aaaa")
    }
} else {
    print("bbb")
}
