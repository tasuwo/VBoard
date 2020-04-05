///
/// @Generated by Mockolo
///



@testable import Domain
import RxRelay
import RxSwift


public class SearchServiceProtocolMock: SearchServiceProtocol {
    public init() { }
    public init(state: BehaviorRelay<SearchServiceQuery>, command: PublishRelay<SearchServiceCommand>) {
        self._state = state
        self._command = command
    }

    public var stateSetCallCount = 0
    private var _state: BehaviorRelay<SearchServiceQuery>!  { didSet { stateSetCallCount += 1 } }
    public var state: BehaviorRelay<SearchServiceQuery> {
        get { return _state }
        set { _state = newValue }
    }

    public var commandSetCallCount = 0
    private var _command: PublishRelay<SearchServiceCommand>!  { didSet { commandSetCallCount += 1 } }
    public var command: PublishRelay<SearchServiceCommand> {
        get { return _command }
        set { _command = newValue }
    }
}
