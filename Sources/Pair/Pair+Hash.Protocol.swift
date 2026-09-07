extension Pair: Hash::Hash.`Protocol`
where
    First: Hash::Hash.`Protocol` & ~Copyable,
    Second: Hash::Hash.`Protocol` & ~Copyable
{}
