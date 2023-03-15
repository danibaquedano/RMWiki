import Foundation

class CharactersViewModel: ObservableObject {
    
    private let remoteService : RemoteService
    
    @Published var characters: [Character] = []
    @Published var filterName = ""
    @Published var filterStatus = ""
    @Published var filterGender = ""
    @Published var getCharactersError: Error?
    
    var numResults = 0
    private var currentPage = 1
    private var maxPage = 0
    
    var isFiltered: Bool {
        filterName != "" || filterGender != "" || filterStatus != ""
    }
    
    init(remoteService: RemoteService) {
        self.remoteService = remoteService
    }
    
    @MainActor
    func getCharacters() {
        Task {
            do {
                currentPage = 1
                let charactersInfo = try await remoteService.getCharacters(pageIndex: currentPage, name: filterName, status: filterStatus, gender: filterGender)
                characters = charactersInfo.characters
                numResults = charactersInfo.numCharacters
                maxPage = charactersInfo.maxPage
            } catch {
                getCharactersError = error
                characters = []
                numResults = 0
            }
        }
    }
    @MainActor
    func getMoreCharacters() {
        Task {
            if currentPage + 1 <= maxPage {
                currentPage += 1
                let nextCharacters = try await remoteService.getCharacters(pageIndex: currentPage, name: filterName, status: filterStatus, gender: filterGender)
                characters.append(contentsOf: nextCharacters.characters)
            }
        }
    }
}
