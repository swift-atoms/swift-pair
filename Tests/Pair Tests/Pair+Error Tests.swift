import Pair
import Testing

@Suite struct `Pair of errors` {
    struct Late: Swift.Error, Equatable {}
    struct Absent: Swift.Error, Equatable {}

    @Test func `two errors that hold at once are thrown as one pair`() {
        #expect(throws: Pair(Late(), Absent())) { throw Pair(Late(), Absent()) }
    }
}
