extension Pair: Swift.Comparable
where
    First: Swift.Comparable & ~Copyable,
    Second: Swift.Comparable & ~Copyable
{

    @inlinable
    public static func < (lhs: borrowing Pair, rhs: borrowing Pair) -> Bool {
        if lhs.first < rhs.first { return true }
        if rhs.first < lhs.first { return false }
        return lhs.second < rhs.second
    }
}
