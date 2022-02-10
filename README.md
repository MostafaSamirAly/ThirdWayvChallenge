# ThirdWayvChallenge

#Design Patterns Used: 

1- Observer Pattern: 
Used for two cases 
1. Binding viewModel properties to viewController
2. Listen to network connection status change

2- Singleton Pattern (Creational Design Pattern):
Used in CoreDataManager and CoreDataConfiguration.
I needed to create only one instance which holds instance to only one managed context that lives through out application running cycle.
And also the core data configuration that provides that only one context. I don’t want to produce a new context every time.


#Design Architecture used is MVVM(Model View ViewModel):
Why MVVM? 
1- Reduce Complexity: makes the view controller simpler by moving a lot of business logic out of it.
2- Expressive: The view model better expresses the business logic for the view
3- Testability: A view model is much easier to test than a view controller.
                You end up testing business logic without having to worry about view implementations.
4- Transparent Communication: The view model provides a transparant interface to the view controller,
                              which it uses to populate the view layer and interact with the model layer
