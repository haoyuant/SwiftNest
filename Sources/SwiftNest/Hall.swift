//
//  Hall.swift
//  SwiftNest
//
//  Created by Haoyuan Tang on 25/2/20.
//

import Foundation
import NIO

public final class Hall {
    
}

final class HallChannelHandler: ChannelInboundHandler {
    public typealias InboundIn = ByteBuffer
    public typealias OutboundOut = ByteBuffer

    // All access to channels is guarded by channelsSyncQueue.
    private let channelsSyncQueue = DispatchQueue(label: "channelsQueue")
    private var channels: [ObjectIdentifier: Channel] = [:]
    
    public func channelActive(context: ChannelHandlerContext) {
        let remoteAddress = context.remoteAddress!
        let channel = context.channel
        self.channelsSyncQueue.async {
            // broadcast the message to all the connected clients except the one that just became active.
            self.writeToAll(channels: self.channels, allocator: channel.allocator, message: "(ChatServer) - New client connected with address: \(remoteAddress)\n")
            
            self.channels[ObjectIdentifier(channel)] = channel
        }
        
        var buffer = channel.allocator.buffer(capacity: 64)
        buffer.writeString("(ChatServer) - Welcome to: \(context.localAddress!)\n")
        context.writeAndFlush(self.wrapOutboundOut(buffer), promise: nil)
    }
    
    public func channelInactive(context: ChannelHandlerContext) {
        let channel = context.channel
        self.channelsSyncQueue.async {
            if self.channels.removeValue(forKey: ObjectIdentifier(channel)) != nil {
                // Broadcast the message to all the connected clients except the one that just was disconnected.
                self.writeToAll(channels: self.channels, allocator: channel.allocator, message: "(ChatServer) - Client disconnected\n")
            }
        }
    }

    public func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        let id = ObjectIdentifier(context.channel)
        var read = self.unwrapInboundIn(data)

        // 64 should be good enough for the ipaddress
        var buffer = context.channel.allocator.buffer(capacity: read.readableBytes + 64)
        buffer.writeString("(\(context.remoteAddress!)) - ")
        buffer.writeBuffer(&read)
        self.channelsSyncQueue.async {
            // broadcast the message to all the connected clients except the one that wrote it.
            self.writeToAll(channels: self.channels.filter { id != $0.key }, buffer: buffer)
        }
    }

    public func errorCaught(context: ChannelHandlerContext, error: Error) {
        print("error: ", error)

        // As we are not really interested getting notified on success or failure we just pass nil as promise to
        // reduce allocations.
        context.close(promise: nil)
    }

    private func writeToAll(channels: [ObjectIdentifier: Channel], allocator: ByteBufferAllocator, message: String) {
        var buffer =  allocator.buffer(capacity: message.utf8.count)
        buffer.writeString(message)
        self.writeToAll(channels: channels, buffer: buffer)
    }

    private func writeToAll(channels: [ObjectIdentifier: Channel], buffer: ByteBuffer) {
        channels.forEach { $0.value.writeAndFlush(buffer, promise: nil) }
    }
}
