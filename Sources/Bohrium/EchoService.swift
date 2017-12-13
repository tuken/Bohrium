//
//  EchoService.swift
//  Bohrium
//
//  Created by 井川司 on 2017/12/13.
//

import Foundation
import KituraWebSocket

class EchoService: WebSocketService {
    
    private var connections = [String: WebSocketConnection]()
    
    public func connected(connection: WebSocketConnection) {
        connections[connection.id] = connection
    }
    
    public func disconnected(connection: WebSocketConnection, reason: WebSocketCloseReasonCode) {
        connections.removeValue(forKey: connection.id)
    }
    
    public func received(message: Data, from: WebSocketConnection) {
        from.close(reason: .invalidDataType, description: "Chat-Server only accepts text messages")
        
        connections.removeValue(forKey: from.id)
    }
    
    public func received(message: String, from: WebSocketConnection) {
        for (connectionId, connection) in connections {
            if connectionId != from.id {
                connection.send(message: message)
            }
        }
    }
}
