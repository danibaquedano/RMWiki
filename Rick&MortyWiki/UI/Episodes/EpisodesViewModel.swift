import Foundation

class EpisodesViewModel: ObservableObject {
    
    private let remoteService: RemoteService
    
    @Published var episodes: [Episode] = []
    private var currentPage = 1
    private var maxPage = 0
    
    init(remoteService: RemoteService) {
        self.remoteService = remoteService
    }
    
    @MainActor
    func getEpisodes(name: String) {
 
        currentPage = 1
        Task {
            let episodesInfo = try await remoteService.getEpisodes(pageIndex: currentPage, name: name)
            episodes = episodesInfo.episodes
            maxPage = episodesInfo.maxPage
        }
    }
    
    @MainActor
    func getMoreEpisodes(name: String) {
        Task {
            if currentPage + 1 <= maxPage {
                currentPage += 1
                let nextEpisodes = try await remoteService.getEpisodes(pageIndex: currentPage, name: name)
                episodes.append(contentsOf: nextEpisodes.episodes)
            }
        }
    }
}
