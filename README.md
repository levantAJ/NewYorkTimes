# NewYorkTimes

- Structure:
    - **Engine**:
        - **Constant**: Contains all constants
        - **Service**: Contains all service api related to network
        - **Database**: Contains all api related to database
        - **Extension**: Contains categories
        - **Utility**: Contains utility classes like Mapping JSON
        - **Factory**: Contains classes to facilitate creating instances
    - **Model**: Contains all entities like `Content`, `Multimedia`, `Article`
    - **ViewModel**:
        - **Home**: Contains all `viewModel`s for **Home** screen 
        - **Articles**: Contains all `viewModel`s for **Detail** screen
        - **SearchArticles**: Contains all `viewModel`s for **Search** screen
    - **View**: 
        - **Home**: Contains all `viewController`s, `cell`s  for **Home** screen 
        - **Articles**: Contains all `viewController`s, `cell`s for **Detail** screen
        - **SearchArticles**: Contains all `viewController`s, `cell`s for **Search** screen
    - **Storyboard**: Contains all storyboards, each screen will have its corresponding storyboard.
    - **Resource**: Images
- Swift 4
- MVVM
- The app supported dynamic fonts.
- How to change `api-key`: Open `API.swift`, go to the bottom, change the value of constant: `NewYorkTimesKey`


<img width="513" alt="screen shot 2018-05-14 at 2 02 04 am" src="https://user-images.githubusercontent.com/6329656/39970261-eacf6f70-571a-11e8-897f-688383867967.png">
<img width="513" alt="screen shot 2018-05-14 at 2 02 22 am" src="https://user-images.githubusercontent.com/6329656/39970262-ecf77900-571a-11e8-8281-9f31f6f3f16a.png">
<img width="513" alt="screen shot 2018-05-14 at 2 01 57 am" src="https://user-images.githubusercontent.com/6329656/39970258-e86d513e-571a-11e8-8062-19b23c55129c.png"

- Tai Le - sirlevantai@gmail.com

