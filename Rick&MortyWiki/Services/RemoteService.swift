
protocol RemoteService {
    func getEpisodes(pageIndex: Int, name: String) async throws -> EpisodesInfo
    func getLocations(pageIndex: Int, name: String) async throws -> LocationsInfo
    func getCharacters(pageIndex: Int, name: String, status: String, gender: String) async throws -> CharactersInfo
}
