import APIKit
import SwiftProtobuf

extension ProtobufBodyParameters {
    init?(message: Message) {
        do {
            self = try .init(protobufObject: message.serializedData())
        }
        catch {
            assertionFailure("\(error)")
            return nil
        }
    }
}
