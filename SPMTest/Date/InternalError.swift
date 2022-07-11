// Created on 10/07/2022

import Foundation

struct InternalError: Error {
    let message: String
}

extension InternalError {
    static var corruptedData: InternalError {
        InternalError(
            message: "Data found not mapped to internal models"
        )
    }
}
