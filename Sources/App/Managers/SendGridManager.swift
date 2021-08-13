
import Vapor
import SendGrid


class SendGridManager {
    
    static let shared = SendGridManager()
    private init() {}
    
    func createEmails(to emailAddresses: [String], body: String) -> [SendGridEmail] {
        var arrayOfEmails : [SendGridEmail] = []
        for x in emailAddresses {
            let personalization     = Personalization(to: [EmailAddress(email: x)], subject: GlobalVariables.shared.emailSubjectLine)
            let email = SendGridEmail(personalizations: [personalization], from: EmailAddress(email: GlobalVariables.shared.fromEmailAddress), subject: GlobalVariables.shared.emailSubjectLine, content: [["type": "text/plain", "value": body]])
            arrayOfEmails.append(email)
        }
        return arrayOfEmails
    }
    
    func sendAllEmails(req: Request, emails: [SendGridEmail]) {
        _ = try? req.application.sendgrid.client.send(emails: emails, on: req.eventLoop.next())
    }
    
    func sendAllEmailsOnApp(app: Application, emails: [SendGridEmail]) {
        _ = try? app.sendgrid.client.send(emails: emails, on: app.eventLoopGroup.next())

    }
}
