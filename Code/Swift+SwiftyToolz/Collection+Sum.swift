public extension Collection
{
    func sum<Number: Numeric>(_ ofEach: (Element) -> Number) -> Number
    {
        reduce(0) { $0 + ofEach($1) }
    }
    
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    func sum<Number: Numeric>(_ ofEach: (Element) async -> Number) async -> Number
    {
        var sum: Number = 0
        
        for element in self
        {
            sum += await ofEach(element)
        }
        
        return sum
    }
}
