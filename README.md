# GitHub Repositories Search
<p align="center">
    <img src="./Docs/GITHUB-02.png"
         alt="PyKanban-logo"
         width="195px"
         style="display: block; margin: 0 auto"/>
</p>
## Overview

GitHub Repositories Viewer is a straightforward iOS application designed to enable users to explore GitHub repositories. The app leverages the GitHub API to fetch repository data, presenting a list of repositories with additional details for each selected repository.
## Demo

<p align="center">
    <img src="./Docs/Simulator Screen Recording - iPhone 11 - 2024-01-14 at 09.54.24.gif"
         alt="Screen Recording - iPhone 11"
         width="255px"
         style="display: block; margin: 0 auto"/>
</p>

## Features

- **Repository List:** View a list of GitHub repositories with basic information.
- **Pagination:** Load repositories in batches for improved performance.
- **Repository Details:** Access detailed information about a selected repository.
- **Caching:** Cache repository details to reduce API calls and enhance user experience.
- **Search:** Search for repositories by name, with a minimum of 2 characters.

## Technologies Used

- **Swift:** The project is implemented in the Swift programming language.
- **UIKit:** The user interface is constructed using the UIKit framework.
- **Realm:** A mobile database utilized for caching repository details.
- **GitHub API:** Integration with the GitHub API for fetching repository data.

### Prerequisites

- Xcode: Ensure you have the latest version of Xcode installed.

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/AmrMohamad/GH-Repo-Search.git
   cd GH-Repo-Search
   ```
1. Install the required dependencies using CocoaPods:

   ```bash
   pod install
   ```

1. Open the GitHubRepositoriesSearch.xcworkspace file in Xcode.

1. Run the app in the simulator or on a physical device.

### Usage
 - Launch the app to view a list of GitHub repositories.
 - Use the search bar to search for repositories by name (minimum 2 characters).
 - Tap on a repository to view its details.

### Code Explanation

#### GitHub Repositories Presenter

##### Overview
   This repository includes a Swift implementation of a GitHub Repositories Presenter. The primary purpose is to interact with a view, manage data from GitHub's API, and offer pagination functionality.

##### Key Components

###### GitHubRepositoriesPresenterProtocol
 - viewDidLoadOfViewRepositories(): Triggered when the view is loaded to fetch and display repositories.

 - showDetailsOf(repository: Repository): Displays detailed information about a selected repository.
 - returnRepositoriesCount() -> Int: Returns the count of repositories.

getUsedRepository(at row:Int) -> Repository: Retrieves the repository at a given index.

 - willDisplayRepository(at row:Int): Called when a repository is about to be displayed, used for triggering pagination.

 - loadItems(withQuery query: String?): Loads repositories based on a search query.

 - resetPagination(): Resets the pagination settings.
 - var repoPerPage: Int { get set }: Property to determine the number of repositories per page.
 - func setPagination(reposPerPage: Int): Manually set up pagination.
##### GitHubRepositoriesPresenter

 - viewRepositories: A weak reference to the view conforming to GitHubRepositoryView.

 - realm: An instance of Realm for data persistence.

 - repos: An array holding GitHub repositories.

 - reposDetails: A dictionary mapping repository URLs to their detailed information.

 - repoPerPage: Property to determine the number of repositories per page.

 - limitForNumberOfRepos: A limit for the total number of repositories.

 - paginationRepos: An array to store repositories for pagination.

##### Methods

 - viewDidLoadOfViewRepositories(): Fetches repositories from GitHub API on view load.

 - showDetailsOf(repository: Repository): Navigates to a detailed view for a selected repository.

 - returnRepositoriesCount() -> Int: Returns the count of repositories for the current pagination.

 - getUsedRepository(at row:Int) -> Repository: Retrieves the repository at a given index.

- willDisplayRepository(at row:Int): Handles the event when a repository is about to be displayed.

 - addNewRepositories(): Implements pagination logic and adds more repositories.

 - setPagination(reposPerPage: Int): Manually sets up pagination.

 - resetPagination(): Resets the pagination settings.

 - loadItems(withQuery query: String?): Loads repositories based on a search query.
 - updatePagination(): Updates pagination based on the current settings.

#### Usage

   Instantiate a GitHubRepositoriesPresenter with a view conforming to GitHubRepositoryView, and use its methods to interact with the view and handle data from GitHub's API. The pagination is automated, but it can also be manually triggered using setPagination.