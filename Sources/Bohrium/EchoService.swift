//
//  EchoService.swift
//  Bohrium
//
//  Created by 井川司 on 2017/12/13.
//

import Foundation
import KituraWebSocket
import LoggerAPI

class EchoService: WebSocketService {
    
    private var connections = [String:WebSocketConnection]()
    
    public func connected(connection: WebSocketConnection) {
        Log.info("connected: connection.id{\(connection.id)}")
        self.connections[connection.id] = connection
    }
    
    public func disconnected(connection: WebSocketConnection, reason: WebSocketCloseReasonCode) {
        Log.info("disconnected: connection.id{\(connection.id)} reason{\(reason)}")
        self.connections.removeValue(forKey: connection.id)
    }
    
    public func received(message: Data, from: WebSocketConnection) {
        Log.info("received(Data): connection.id{\(from.id)}")
        from.close(reason: .invalidDataType, description: "Chat-Server only accepts text messages")
        self.connections.removeValue(forKey: from.id)
    }
    
    public func received(message: String, from: WebSocketConnection) {
        Log.info("received(String): connection.id{\(from.id)} message{\(message)}")
        for (connectionId, connection) in self.connections {
            if connectionId != from.id {
                connection.send(message: message)
            }
        }
    }
}
