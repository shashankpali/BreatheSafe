//
//  WebSocket.swift
//  freshBreath
//
//  Created by Shashank Pali on 12/02/22.
//

import Foundation

@objc public protocol WebSocketDelegate: AnyObject {
    func didReceive(response: String)
    @objc optional func didClosed(response: String)
    @objc optional func didOpened(response: String)
    @objc optional func didFailed(withError: String)
}

class WebSocket: NSObject {
    
    public weak var delegate: WebSocketDelegate?
    private var isConnected = false
    private var urlString: String?
    private var webSocket: URLSessionWebSocketTask?
    
    static let shared = WebSocket()

    private override init() {}
    
    public func connection(urlString: String) {
        self.urlString = urlString
        connect()
    }
    
    public func connect() {
        guard isConnected == false, let url = self.urlString else {return}
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        webSocket = session.webSocketTask(with: URL(string: url)!)
        webSocket?.resume()
    }
    
    public func disConnect() {
        webSocket?.cancel(with: .goingAway, reason: "app closed".data(using: .utf8))
        isConnected = false
    }
}

extension WebSocket: URLSessionWebSocketDelegate {
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        isConnected = true
        ping()
        receive()
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        self.failed(withError: String(data: reason ?? Data(), encoding: .utf8) ?? "Error")
    }
}

extension WebSocket {
    private func ping() {
        webSocket?.sendPing { error in
            if let error = error {
                self.failed(withError: error.localizedDescription)
            }
        }
    }
    
    private func receive() {
        webSocket?.receive { [unowned self] result in
            switch result {
            case .success(let message):
                switch message {
                case .data(let data):
                    print("got data \(data)")
                case .string(let msg):
                    delegate?.didReceive(response: msg)
                @unknown default:
                    break
                }
                break
            case .failure(let error):
                self.failed(withError: error.localizedDescription)
                break
            }
            guard isConnected else {return}
            self.receive()
        }
    }
    
    private func failed(withError: String) {
        delegate?.didFailed?(withError: withError)
        self.disConnect()
    }
}
