import Hash
import Pair
import Equation
import Testing

struct Ranked: ~Copyable, Sendable {
    let value: Int
}

extension Ranked: Hash.`Protocol` {
    borrowing func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
}

@Suite
struct `Pair Hash Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
    @Suite(.serialized) struct Performance {}
}

extension `Pair Hash Tests`.Unit {

    @Test
    func `Pair is natively hashable through the seam`() {
        let first = Pair(Value(raw: 1), Value(raw: 2))
        let equal = Pair(Value(raw: 1), Value(raw: 2))
        let different = Pair(Value(raw: 2), Value(raw: 1))

        #expect(Set([first, equal, different]).count == 2)
    }

    @Test
    func `noncopyable Pair supplies Hash's domain-typed value`() {
        let first = Pair(Ranked(value: 7), Ranked(value: 8))
        let second = Pair(Ranked(value: 7), Ranked(value: 8))

        let firstHash: Hash.Value = hash(first)
        let secondHash: Hash.Value = hash(second)
        #expect(firstHash == secondHash)
    }
}

private struct Value: Hash.`Protocol` {
    let raw: Int

    func hash(into hasher: inout Hasher) {
        hasher.combine(raw)
    }
}

private func hash<T: Hash.`Protocol` & ~Copyable>(
    _ value: borrowing T
) -> Hash.Value {
    value.hashValue
}
