import Foundation
import KituraNet
import KituraWebSocket
import HeliumLogger
import LoggerAPI

HeliumLogger.use(.info)

WebSocket.register(service: EchoService(), onPath: "chat")

class EchoServerDelegate: ServerDelegate {
    public func handle(request: ServerRequest, response: ServerResponse) {}
}

let server = HTTP.createServer()
server.delegate = EchoServerDelegate()

do {
    try server.listen(on: 8080)
    ListenerGroup.waitForListeners()
}
catch {
    Log.error("Error listening on port 8080: \(error).")
}
