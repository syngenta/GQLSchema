import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ContainerTypeTests.allTests),
        testCase(FieldTests.allTests),
        testCase(InlineFragmentTests.allTests),
        testCase(InputTypeTests.allTests),
        testCase(ParameterTests.allTests),
        testCase(ReferenceTypeTests.allTests),
        testCase(TypedFieldTests.allTests),
        testCase(ValueTypeTests.allTests),
        testCase(VariableTests.allTests)
    ]
}
#endif
