import Foundation

struct Location: Decodable, Identifiable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
}

struct Character: Decodable, Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: ResumeLocation
    let location: ResumeLocation
    let image: String
    let episode: [String]
}

struct Episode: Decodable, Identifiable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
}

struct ResumeLocation: Decodable {
    let name: String
    let url:  String
}

struct Info: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
