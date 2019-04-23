import Foundation

public enum ProtobufResponseError: Error, Equatable {
    /// Data object failed to serialize to protobuf data.
    case parseFailed(Data)
    /// Response status is not success.
    case requestFailed(data: Data?, response: HTTPURLResponse)
}
