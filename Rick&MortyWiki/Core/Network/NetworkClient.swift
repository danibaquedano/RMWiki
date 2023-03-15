import Foundation

protocol NetworkClient {
    func call<Output: Decodable>(for urlRequest: URLRequest) async throws -> Output
}
