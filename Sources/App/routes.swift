
import Vapor
import Jobs

func routes(_ app: Application) throws {
    
    //MARK: JOBS
    
    let req     = Request(application: app, on: app.eventLoopGroup.next())
  
    
        let hours   = GlobalVariables.shared.hoursInMilTimeForDailyEmail 
        let minutes = getMinutesUntil(militaryTimeHour: hours)
        Jobs.oneoff(delay: (minutes * 60).seconds) {
            Jobs.add(interval: 1.days) {
                _ = NetworkManager.shared.getErrorsFromCallLogsEndpoint(req: req, howManyDaysAgo: 1).map { object in
                    let errorObjects =  getErrorsByKey(object: object)
                    if errorObjects.count > 0 {
                        var bodyString = ""
                        for x in errorObjects {
                            var stringToAppend = """
                                 
                                 API Key: \(x.apiKey)
                                 """
                            for y in x.responseCode {
                                var responsesStringToAppend = """
                                 
                                     Response Code: \(y.responseCode)
                                     Count: \(y.count)
                                     Datestamps:
                                 """
                                for z in y.dateArray {
                                    let timeStamp = """
                                         
                                                 \(z)
                                         """
                                    responsesStringToAppend.append(
                                         """
                                         \(timeStamp)
                                         """)
                                }
                                stringToAppend.append(responsesStringToAppend)
                                
                            }
                            bodyString.append(stringToAppend)
                        }
                        let emails = SendGridManager.shared.createEmails(to: GlobalVariables.shared.toEmailAddresses, body: bodyString)
                        SendGridManager.shared.sendAllEmailsOnApp(app: app, emails: emails)
                    } else {
                        let emails = SendGridManager.shared.createEmails(to: GlobalVariables.shared.toEmailAddresses, body: "There are no errors to report today")
                        SendGridManager.shared.sendAllEmailsOnApp(app: app, emails: emails)
                    }
                }
            }
        }
    
    
    
    //MARK: ENDPOINTS
    
    app.get("errors", ":numberOfDays") {req -> SuccessOrFailure in
        if req.headers.first(where: { name, value in
            if name == "Authorization" && value == GlobalVariables.shared.authKey {
                return true
            } else {
                return false
            }
        }) != nil {
            let days = req.parameters.get("numberOfDays", as: Int.self) ?? 1
            return .success(NetworkManager.shared.getErrorsFromCallLogsEndpoint(req: req, howManyDaysAgo: days))
        } else {
            return .forbidden(.forbidden)
        }
        
    }
    
    app.get("hello") {req -> String in
        return "Hello, universe!"
    }
    
    app.get("test") { req -> EventLoopFuture<String> in
        return NetworkManager.shared.getErrorsFromCallLogsEndpoint(req: req, howManyDaysAgo: 1).map { object in
            let errorObjects =  getErrorsByKey(object: object)
            if errorObjects.count > 0 {
                var bodyString = ""
                for x in errorObjects {
                    var stringToAppend = """
                         
                         API Key: \(x.apiKey)
                         """
                    for y in x.responseCode {
                        var responsesStringToAppend = """
                         
                             Response Code: \(y.responseCode)
                             Count: \(y.count)
                             Datestamps:
                         """
                        for z in y.dateArray {
                            let timeStamp = """
                                 
                                         \(z)
                                 """
                            responsesStringToAppend.append(
                                 """
                                 \(timeStamp)
                                 """)
                        }
                        stringToAppend.append(responsesStringToAppend)
                        
                    }
                    bodyString.append(stringToAppend)
                    
                }
                let emails = SendGridManager.shared.createEmails(to: GlobalVariables.shared.toEmailAddresses, body: bodyString)
                SendGridManager.shared.sendAllEmails(req: req, emails: emails)
            } else {
                let emails = SendGridManager.shared.createEmails(to: GlobalVariables.shared.toEmailAddresses, body: "There are no errors to report")
                SendGridManager.shared.sendAllEmails(req: req, emails: emails)
            }
            return "Successfully connected to Tyk. Sending test email now to \(String(describing: GlobalVariables.shared.toEmailAddresses.first)) from \(GlobalVariables.shared.fromEmailAddress) (which must be associated with your SendGrid account) at \(GlobalVariables.shared.hoursInMilTimeForDailyEmail):00"
            
        }
        
    }
}
