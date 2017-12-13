import Foundation
import KituraNet
import KituraWebSocket
import HeliumLogger
import LoggerAPI

HeliumLogger.use(.info)

WebSocket.register(service: EchoService(), onPath: "echo")

class EchoServerDelegate: ServerDelegate {
    
    public func handle(request: ServerRequest, response: ServerResponse) {
        Log.info("EchoServerDelegate handle")
    }
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
