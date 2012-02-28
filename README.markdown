#CCJSONDataSource is an iOS singleton object intended to be subclassed in iOS applications that use HTTP JSON as their data source.

##Overview


###If you have an application that will use a JSON API as it's datasource, and your application is called Hello…

* Import the classes in this repo & NSString+CCAdditions from my CCAdditions repo
* Subclass CCJSONDataSource with the name HelloDataSource or similar, implement as a singleton that's imported into your prefix file if you'd like to access it similarly to [[HelloDataSource shared] methodName] in all of your controllers
* I recommend you add a define in your sublass that's the prefix of your API, like http://hello.com/api so you can keep your code DRY

Note that CCJSONDataSource itself is not asynchronous, but in practive all of the subclasses I create using it are. I use Grand Central Dispatch with custom blocks to asynchronously deliver the data back to the calling controller.