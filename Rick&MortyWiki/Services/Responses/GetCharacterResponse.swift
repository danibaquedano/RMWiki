struct GetCharacterResponse: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: ResumeLocationDTO
    let location: ResumeLocationDTO
    let image: String
    let episode: [String]
}
