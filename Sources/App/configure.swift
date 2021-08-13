import Vapor

public func configure(_ app: Application) throws {
    GlobalVariables.shared.initializeEnvironmentVariables()
    app.sendgrid.initialize()
    try routes(app)
}
