@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
public extension Sequence
{
    func asyncMap<Mapped>(_ transform: @Sendable (Element) async throws -> Mapped) async rethrows -> [Mapped]
    {
        // TODO: parallelize this using task group but maintaining order ... or is this rather an application of AsyncSequence???
        
        var result = [Mapped]()
        
        for element in self
        {
            result += try await transform(element)
        }
        
        return result
    }
}
