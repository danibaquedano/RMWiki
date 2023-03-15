import Foundation

class URLSessionNetworkClient: NetworkClient {
    func call<Output: Decodable>(for urlRequest: URLRequest) async throws -> Output {
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let httpUrlResponse = response as? HTTPURLResponse else { throw NetworkError.other }
        
        switch httpUrlResponse.statusCode {
        case 200...299: break
        case 400...499: throw NetworkError.clientError
        case 500...599: throw NetworkError.serverError
        default: throw NetworkError.other
        }
        
        do {
            if Output.self == EmptyResponse.self {
                let emptyResponse: Output = EmptyResponse() as! Output
                return emptyResponse
            }
            
            let decodedResponseData = try JSONDecoder().decode(Output.self, from: data)
            return decodedResponseData
            
        } catch {
            throw NetworkError.mappingToDTO
        }
    }
}
