import Foundation

struct RemoteServiceLive: RemoteService {
    
    enum Endpoint: String {
        case episode = "episode"
        case location = "location"
        case character = "character"
    }
    
    enum FilterParameters: String {
        case name = "name"
        case page = "page"
        case status = "status"
        case gender = "gender"
    }
    
    private let networkClient: NetworkClient
    private let baseURL = "https://rickandmortyapi.com/api/"
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getEpisodes(pageIndex: Int, name: String) async throws -> EpisodesInfo {
        
        let response: ApiResponse<Episode> =
        try await makeRequest(endPoint: .episode,
                              pageIndex: pageIndex,
                              name: name)
        
        return EpisodesInfo(episodes: response.results,
                            maxPage: response.info.pages,
                            numEpisodes: response.info.count)
    }
    
    func getLocations(pageIndex: Int, name: String) async throws -> LocationsInfo {
        
        let response: ApiResponse<Location> =
        try await makeRequest(endPoint: .location,
                              pageIndex: pageIndex,
                              name: name)
        
        return LocationsInfo(locations: response.results,
                             maxPage: response.info.pages,
                             numLocations: response.info.count)
    }
    
    func getCharacters(pageIndex: Int, name: String, status: String, gender: String) async throws -> CharactersInfo {
        
        let response: ApiResponse<Character> =
        try await makeRequest(endPoint: .character,
                              pageIndex: pageIndex,
                              name: name,
                              status: status,
                              gender: gender)
        
        return CharactersInfo(characters: response.results,
                              maxPage: response.info.pages,
                              numCharacters: response.info.count)
    }
    
    private func makeRequest<Output: Decodable> (
        endPoint: Endpoint,
        pageIndex: Int,
        name: String,
        status: String? = nil,
        gender: String? = nil
    ) async throws -> Output {
        
        let endPoint = endPoint.rawValue
        let httpMethod = "GET"
        
        guard var urlComponents = URLComponents(string: baseURL) else {
            throw NetworkError.clientError
        }
        
        urlComponents.path += "\(endPoint)"
        
        urlComponents.queryItems = makeURLParameters(pageIndex: pageIndex, name: name, status: status, gender: gender)
        
        guard let requestUrl = urlComponents.url else {
            throw NetworkError.clientError
        }
        
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = httpMethod
        urlRequest.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        return try await networkClient.call(for: urlRequest)
    }
    
    private func makeURLParameters(pageIndex: Int, name: String, status: String?, gender: String?) -> [URLQueryItem] {
        
        var urlParameters: [URLQueryItem] = []
        urlParameters.append(URLQueryItem(name: FilterParameters.page.rawValue, value: pageIndex.formatted()))
        
        if name != "" {
            urlParameters.append(URLQueryItem(name: FilterParameters.name.rawValue, value: name))
        }
        if status != "" {
            urlParameters.append(URLQueryItem(name: FilterParameters.status.rawValue, value: status))
        }
        if gender != "" {
            urlParameters.append(URLQueryItem(name: FilterParameters.gender.rawValue, value: gender))
        }
        return urlParameters
    }
}
