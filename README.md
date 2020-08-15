# redditList
Loblaws

1. Please 'pod install' to install dependencies,
2. 'SDWebImage' is used for thumbnail image loading,
3. Using 'Decodable' protocol to map API Json data to data model,
4. UISplitViewController is used, so an iPhone would display list and detail on the separate screens, whereas an iPad would display both list and detail side-by-side,
5. For detail view, UIScrollview is used for container, in case the article body is long,
6. For article body, 'media_embed' is not included for display,
7. Architecture:
    
                           DataModel
                 (using)       |          (binding)
     NetworkAPI <--------- DataSource Repo  ------------------- ViewModel
                                                                                                           | (binding)
                                                                                             View(controller, client)
