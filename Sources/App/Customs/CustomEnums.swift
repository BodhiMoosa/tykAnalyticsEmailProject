
import Vapor

enum CustomErrors : String, Error {
    case responseCodeError = "responseCodeError"
}

enum SuccessOrFailure : ResponseEncodable {
    func encodeResponse(for request: Request) -> EventLoopFuture<Response> {
        switch self {
        case .forbidden(let status):
            return status.encodeResponse(for: request)
        case .success(let days):
            return days.encodeResponse(for: request)
        }
    }
    
    case success(EventLoopFuture<CallLogObject>)
    case forbidden(HTTPResponseStatus)
}
