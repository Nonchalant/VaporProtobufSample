//
//  Message+Encode.swift
//  App
//
//  Created by Ihara Takeshi on 2018/01/02.
//

import Foundation
import SwiftProtobuf

extension SwiftProtobuf.Message {
    func encodeData(with acceptType: AcceptType) -> Data {
        switch acceptType {
        case .protobuf:
            return try! serializedData()
        case .json:
            return try! jsonUTF8Data()
        }
    }
}
