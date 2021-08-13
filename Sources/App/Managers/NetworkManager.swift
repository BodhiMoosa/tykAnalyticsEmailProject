
import Vapor
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func getErrorsFromCallLogsEndpoint(req: Request, howManyDaysAgo: Int) -> EventLoopFuture<CallLogObject> {
        // start and end values are seconds from epoch
        let promise     = req.eventLoop.makePromise(of: CallLogObject.self)
        let startDate   = Date().timeIntervalSince1970 - Double((howManyDaysAgo * 86400))
        let endDate     = Date().timeIntervalSince1970
        let url         = URL(string: "\(GlobalVariables.shared.adminBaseURL)/api/logs/?start=\(Int(ceil(startDate)))&end=\(Int(ceil(endDate)))&p=0&errors=1")!
        var request     = URLRequest(url: url)
        request.addValue(GlobalVariables.shared.authKey, forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                promise.fail(error)
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                promise.fail(CustomErrors.responseCodeError)
                return
            }
            guard let data = data else { return }
            do {
                let dataToReturn = try JSONDecoder().decode(CallLogObject.self, from: data)
                promise.succeed(dataToReturn)
                return
            } catch {
                promise.succeed(CallLogObject(data: [], pages: 0))
            }
        }
        task.resume()
        return promise.futureResult
    }
    
    func getErrorsFromCallLogsEndpointOnApp(app: Application, howManyDaysAgo: Int) -> EventLoopFuture<CallLogObject> {
        // start and end values are seconds from epoch
        
        let promise     = app.eventLoopGroup.next().makePromise(of: CallLogObject.self)
        let startDate   = Date().timeIntervalSince1970 - Double((howManyDaysAgo * 86400))
        let endDate     = Date().timeIntervalSince1970
        let url         = URL(string: "\(GlobalVariables.shared.adminBaseURL)/api/logs/?start=\(Int(ceil(startDate)))&end=\(Int(ceil(endDate)))&p=0&errors=1")!
        var request     = URLRequest(url: url)
        request.addValue(GlobalVariables.shared.authKey, forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                promise.fail(error)
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                promise.fail(CustomErrors.responseCodeError)
                return
            }
            guard let data = data else { return }
            do {
                let dataToReturn = try JSONDecoder().decode(CallLogObject.self, from: data)
                promise.succeed(dataToReturn)
                return
            } catch {
                promise.succeed(CallLogObject(data: [], pages: 0))
            }
        }
        task.resume()
        return promise.futureResult
    }
}
