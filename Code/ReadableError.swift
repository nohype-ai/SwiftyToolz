@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
public func log(_ error: ReadableError,
                title: String? = nil,
                forUser: Bool = false,
                filePath: String = #file,
                function: String = #function,
                line: Int = #line)
{
    log(error: error.message,
        title: title,
        forUser: forUser,
        filePath: filePath,
        function: function,
        line: line)
}

public extension Error
{
    static func readable(_ message: String) -> ReadableError { .init(message) }
    
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    var readable: ReadableError
    {
        switch self
        {
        case let readableError as ReadableError:
            return readableError
        case let string as String:
            return ReadableError(string)
        case let readableErrorConvertible as ReadableErrorConvertible:
            return ReadableError(readableErrorConvertible.readableErrorMessage)
        case let customDebugStringConvertible as CustomDebugStringConvertible:
            return ReadableError(customDebugStringConvertible.debugDescription)
        case let customStringConvertible as CustomStringConvertible:
            return ReadableError(customStringConvertible.description)
        default:
            log(warning: "Could not retrieve proper readable message from Error of type \(typeName(self))")
            return ReadableError("\(self)")
        }
    }
}

public protocol ReadableErrorConvertible
{
    var readableErrorMessage: String { get }
}

extension String: @retroactive Error {}

public struct ReadableError: Error, CustomStringConvertible, CustomDebugStringConvertible
{
    public init(_ message: String) { self.message = message }
    
    public var description: String { message }
    
    public var debugDescription: String { message }

    public let message: String
}
