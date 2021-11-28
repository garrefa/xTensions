
import Foundation

public extension NSObject {
    class var className: String {
        String(describing: self)
    }
}
