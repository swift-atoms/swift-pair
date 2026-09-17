extension Pair: Swift.Equatable
where
    First: Swift.Equatable & ~Copyable,
    Second: Swift.Equatable & ~Copyable
{

    @inlinable
    public static func == (lhs: borrowing Pair, rhs: borrowing Pair) -> Bool {
        lhs.first == rhs.first && lhs.second == rhs.second
    }
}
