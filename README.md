# Unknown Detections API - Microverse final capstone project.

This is unknown detections RoR API witch counts with user(create), posts(index and create), and favorites(index, create and destroy) endpoints. The react client app can be found [here](https://github.com/Shaqri/unknown-detection-client).

## Usage

- AUTHENTICATION:  

POST `https://unknow-detections.herokuapp.com/api/v1/users`  
params -> user => name, email, password, password confirmation
>> Creates a new user in the database and responds with AuthToken, username, and user email.  

POST `https://unknow-detections.herokuapp.com/api/v1/auth`    
params -> user => email, password  
>> Checks for user in database and respond with AuthToken, username and user email if found.  

- POSTS:    

GET `https://unknow-detections.herokuapp.com/api/v1/posts`  
optional headers -> Authorization:"Bearer 'AuthToken'"
>> Respond with an array containing all created posts.  

GET `https://unknow-detections.herokuapp.com/api/v1/posts?search=:search_query`  
URL params -> search_query
>> Respond with all posts where its title matches or matches part of the search query.    

GET `https://unknow-detections.herokuapp.com/api/v1/posts/:id`  
URL params -> post_id
>> Respond with data of post id passed in url.  

- FAVORITES

GET `https://unknow-detections.herokuapp.com/api/v1/favorites`  
headers -> Authorization:"Bearer 'AuthToken'"
>> Respond with an array of all favorite posts of the current user.  

POST `https://unknow-detections.herokuapp.com/api/v1/favorites`  
headers -> Authorization:"Bearer 'AuthToken'"
params -> favorite => post_id
>> Creates a favorite relationship between post and current user and respond with record id with relationships.  

DELETE `https://unknow-detections.herokuapp.com/api/v1/favorites/:id`  
headers -> Authorization:"Bearer 'AuthToken'"
URL params -> favorite_id
>> Destroy favorite relationship and respond with successful message.  
## Built With

- Ruby
- Ruby on Rails
- RSpec
- JWT
- AWS
- PG SQL
- JSON Serializer

## Getting Started

To get a local copy up and running follow these simple example steps.

- Git clone https://github.com/Shaqri/unknown-detection-api.git
- Move to the root directory in your command line
- run `bundle install` to install all dependencies
- run `rails server to start rails server in localhost

## Test   

To run all available tests run `bundle exec rspect in your terminal.  

## ENV variables  

To implement ENV variables follow the examples contained in the '.evn-example' file located in the root directory and after modifying the file rename it with '.env'.  

## Author
👤 Victor Gonzalez  
- Github: [@Shaqri](https://github.com/Shaqri)
- Twitter: [@victorgonbu1](https://twitter.com/Victorgonbu1)
- LinkedIn: [Victor Gonzalez](https://www.linkedin.com/in/victor-manuel-gonzalez-buitrago)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](issues/).

## Show your support

Give a ⭐️ if you like this project!
