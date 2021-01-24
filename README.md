# Github-App
 Github App is an iOS application written using Swift language.

## Application Features
### Search Repositories Scene
- The user is able to search along public repositories on github.
- Results are shown in tableView on this page.
- Cells contain avatar (or gravatar) of owner , and username and repo’s name
- When user clicks avatar, application opens User Detail Page.
- When user clicks anywhere except image, Repository Detail page is shown.
- Page has ability to paginate.

### Repository Detail Scene
- This page is going to show detail of repository (Repo Name , Owner username, Avatar email, fork count, Language, default branch name etc.
- When user clicks avatar, User Detail page is shown.

### User Detail Scene
- This page shows the owner details of clicked repository.
- Page shows some basic user information like email,username,avatar etc.
- Page shows repositories of user.
- Page has ability to paginate
- This page contains one tableView which contains 2 types of cell. First is
userData, others are repository cells.

## Architecture
This project is designed by MVVM-C architecture pattern where:

![](https://github.com/haydarKarkin/Github-App/blob/main/images/mvvm-c.jpg)

- View is represented by `UIViewController` designed in Storyboard
- Model represents state and domain objects
- ViewModel interacts with Model and prepares data to be displayed. View uses ViewModel's data either directly or through bindings (using Closures) to configure itself. View also notifies ViewModel about user actions like button tap. ViewModels transform inputs from view and return an output object that holds data/actions.
- Service layer is where the logic of dealing with responses from the network request is handled. ViewModels should interface this layer to get updated data as necessary.
- Coordinator is responsible for handling application flow, decides when and where to go based on events from ViewModel (trigers routing functions).

`View` <- `ViewController` <- bindings -> (`ViewModel` -> `Model`) <- trigers -> `Coordinator`