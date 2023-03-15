import Foundation

class LocationsViewModel: ObservableObject {
    
    private let remoteService : RemoteService
    
    @Published var locations: [Location] = []
    @Published var nameFiltered = ""
    private var currentPage = 1
    private var maxPage = 0
    
    init(remoteService: RemoteService) {
        self.remoteService = remoteService
    }
    
    @MainActor
    func getLocations(name: String) {
        Task {
            currentPage = 1
            let locationsInfo = try await remoteService.getLocations(pageIndex: currentPage, name: name)
            locations = locationsInfo.locations
            maxPage = locationsInfo.maxPage
        }
    }
    
    @MainActor
    func getMoreLocations(name: String) {
        Task {
            if currentPage + 1 <= maxPage {
                currentPage += 1
                let nextEpisodes = try await remoteService.getLocations(pageIndex: currentPage, name: name)
                locations.append(contentsOf: nextEpisodes.locations)
            }
        }
    }
}
