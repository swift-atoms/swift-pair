import Comparison
import Pair
import Testing

struct Ranked: ~Copyable, Sendable {
    let value: Int
}

extension Ranked: Comparison.`Protocol` {
    static func < (lhs: borrowing Self, rhs: borrowing Self) -> Bool {
        lhs.value < rhs.value
    }
}

@Suite
struct `Pair Comparison Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
    @Suite(.serialized) struct Performance {}
}

extension `Pair Comparison Tests`.Unit {

    @Test
    func `pair conditionally satisfies Comparison Protocol`() {
        func acceptsComparisonProtocol<T: Comparison.`Protocol`>(_ value: T) -> T {
            value
        }

        let pair = Pair(1, 2)
        #expect(acceptsComparisonProtocol(pair) == pair)
    }

    @Test
    func `comparable lexicographic less than first`() {
        let a = Pair(1, 100)
        let b = Pair(2, 0)
        #expect(a < b)
    }

    @Test
    func `comparable lexicographic tie break on second`() {
        let a = Pair(1, 5)
        let b = Pair(1, 7)
        #expect(a < b)
    }

    @Test
    func `comparable equal pairs are not less`() {
        let a = Pair(3, 4)
        let b = Pair(3, 4)
        #expect(a == b)
        #expect(!(a < b))
        #expect(!(b < a))
    }

    @Test
    func `comparable greater than via reverse`() {
        let a = Pair(2, 0)
        let b = Pair(1, 100)
        #expect(a > b)
    }

    @Test
    func `comparison protocol noncopyable pair lexicographic`() {
        let a = Pair(Ranked(value: 1), Ranked(value: 100))
        let b = Pair(Ranked(value: 2), Ranked(value: 0))
        let result: Bool = a < b
        #expect(result)
    }

    @Test
    func `comparison protocol noncopyable pair tie break`() {
        let a = Pair(Ranked(value: 1), Ranked(value: 5))
        let b = Pair(Ranked(value: 1), Ranked(value: 7))
        let result: Bool = a < b
        #expect(result)
    }
}
