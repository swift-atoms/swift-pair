extension Pair: Swift.Hashable
where
    First: Swift.Hashable & ~Copyable,
    Second: Swift.Hashable & ~Copyable
{

    @inlinable
    public borrowing func hash(into hasher: inout Hasher) {
        first.hash(into: &hasher)
        second.hash(into: &hasher)
    }
}
