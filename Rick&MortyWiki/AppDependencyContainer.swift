import SwiftUI

typealias LaunchScreen = LaunchView<MasterScreen>
typealias MasterScreen = MasterView<CharactersScreen, LocationsScreen, EpisodesScreen>
typealias EpisodesScreen = EpisodesView
typealias CharactersScreen = CharactersView
typealias LocationsScreen = LocationsView

class AppDependencyContainer {
    let repositoriesContainer: RepositoriesDependencyContainer
    
    init() {
        repositoriesContainer = RepositoriesDependencyContainer()
    }
    //MARK: LaunchView
    
    func makeLaunchView() -> LaunchScreen {
        .init(
            makeMasterScreen: makeMasterView)
    }
    
    // MARK: - Master
    func makeMasterView() -> MasterScreen {
        .init(
            makeCharactersScreen: makeCharactersScreen,
            makeLocationsScreen: makeLocationsScreen,
            makeEpiosdesScreen: makeEpisodesScreen)
    }
    
    // MARK: - Episodes
    func makeEpisodesScreen() -> EpisodesScreen {
        .init(
            viewModel: .init(
                remoteService: repositoriesContainer.remoteService)
        )
    }
    
    // MARK: - Characters
    func makeCharactersScreen() -> CharactersScreen {
        .init(
            viewModel: .init(
                remoteService: repositoriesContainer.remoteService)
        )
    }
    
    // MARK: - Locations
    func makeLocationsScreen() -> LocationsScreen {
        .init(
            viewModel: .init(
                remoteService: repositoriesContainer.remoteService)
        )
    }
}
