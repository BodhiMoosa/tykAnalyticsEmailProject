
import Vapor

class GlobalVariables {
    static let shared = GlobalVariables()
    private init() {}
    func initializeEnvironmentVariables() {
        guard let hoursForEmail = Environment.get("HOUR_FOR_EMAIL") else {
            fatalError("HOUR_FOR_EMAIL environment variable required")
        }
        if let inty = Int(hoursForEmail) { hoursInMilTimeForDailyEmail = inty }
        
        guard var adminBaseURL = Environment.get("ADMIN_BASE_URL") else {
            fatalError("ADMIN_BASE_URL environment variable required")
        }
        if adminBaseURL.last == "/" {
            adminBaseURL.removeLast()
        }
        self.adminBaseURL = adminBaseURL
        
        guard let emailSubjectLine = Environment.get("EMAIL_SUBJECT") else {
            fatalError("EMAIL_SUBJECT environment variable required")
        }
        self.emailSubjectLine = emailSubjectLine
        
        guard let fromEmailAddress = Environment.get("FROM_EMAIL") else {
            fatalError("FROM_EMAIL environment variable required")
        }
        self.fromEmailAddress = fromEmailAddress
        
        guard let firstEmailAddressToSendTo = Environment.get("TO_ADDRESS") else {
            fatalError("TO_ADDRESS environment variable required")
        }
        self.toEmailAddresses.append(firstEmailAddressToSendTo)
        
        guard let tykAuthKey = Environment.get("TYK_AUTH_KEY") else {
            fatalError("TYK_AUTH_KEY environment variable required")
        }
        self.authKey = tykAuthKey
        self.toEmailAddresses.append(firstEmailAddressToSendTo)
        

        
    }
    
    //hoursInMilTimeForDailyEmail is the hour at which you want emails to be sent (daily)
    var hoursInMilTimeForDailyEmail : Int = 12
    //adminBaseURL should not here include trailing forward slash
    var adminBaseURL                = ""
    //authKey is found in an individual User's settings
    var authKey                     = ""
    //emailSubjectLine is the subject line for your error emails
    var emailSubjectLine            = ""
    //fromEmailAddress should be the email address your SendGrid account is authorized from which to send emails
    var fromEmailAddress            = ""
    //toEmailAddresses contains all email address to which you want to send error reports; however, each email counts against your SendGrid quota
    var toEmailAddresses : [String] = [""]
    
    
    
}

