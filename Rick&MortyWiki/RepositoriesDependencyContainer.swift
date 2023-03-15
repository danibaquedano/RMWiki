import Foundation

class RepositoriesDependencyContainer {
    private let networkClient: NetworkClient
    let remoteService: RemoteService
 
    init() {
        networkClient = URLSessionNetworkClient()
        remoteService = RemoteServiceLive(networkClient: networkClient)
    }
}
