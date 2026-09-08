import Equation
import Pair
import Testing

struct Ranked: ~Copyable, Sendable {
    let value: Int
}

extension Ranked: Equation.`Protocol` {
    static func == (lhs: borrowing Self, rhs: borrowing Self) -> Bool {
        lhs.value == rhs.value
    }
}

@Suite
struct `Pair Equation Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
    @Suite(.serialized) struct Performance {}
}

extension `Pair Equation Tests`.Unit {

    @Test
    func `equatable conformance`() {
        let a = Pair(1, 2)
        let b = Pair(1, 2)
        let c = Pair(1, 3)
        #expect(a == b)
        #expect(a != c)
    }

    @Test
    func `first component participates in equality`() {
        #expect(Pair(1, 2) != Pair(0, 2))
    }

    @Test
    func `pair satisfies a generic Equation constraint`() {
        func equal<Value: Equation.`Protocol`>(
            _ lhs: borrowing Value,
            _ rhs: borrowing Value
        ) -> Bool {
            lhs == rhs
        }

        #expect(equal(Pair(1, 2), Pair(1, 2)))
        #expect(!equal(Pair(1, 2), Pair(1, 3)))
    }

    @Test
    func `equation protocol noncopyable pair equality`() {
        let a = Pair(Ranked(value: 1), Ranked(value: 2))
        let b = Pair(Ranked(value: 1), Ranked(value: 2))
        let result: Bool = a == b
        #expect(result)
    }

    @Test
    func `equation protocol noncopyable pair inequality`() {
        let a = Pair(Ranked(value: 1), Ranked(value: 2))
        let c = Pair(Ranked(value: 1), Ranked(value: 3))
        let result: Bool = a != c
        #expect(result)
    }
}
