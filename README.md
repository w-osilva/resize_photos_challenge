# Resize photos – SkyHub challenge

Your mission:

* Consume a webservice endpoint (http://54.152.221.29/images.json) that returns a JSON of photos. There are 10 photos.
* Generate three different formats for each photo. The dimensions are: small (320x240), medium (384x288) and large (640x480).
* Write a webservice endpoint that lists (in JSON format) all the ten photos with their respective formats, providing their URLs.

Choose the programming language you want... let us know about why is that your choice.  
Besides the solution itself, write an automated test for your code (using a known framework or just another function/method).

You should use a non-relational database (MongoDB is preferred). Your code should be delivered in your Github account.
We are interested in your solution considering:
1. Correctness;
2. Readability;
3. Automated tests; 
4. Execution time.

## About Solution

### Language choice
I used Ruby ​​because I'm more familiar and because it's the language I like to work with.
The choice was also based on ease of integration with:
* Mongo
* Queue system
* Asynchronous tasks


### Dependencies
* ruby (2.3 or higher)
* rails (5.0.0.1 or higher)
* mongodb (3.4.4 or higher)
* sidekiq
* redis (3.2.8 or higher)
* ImageMagick ([link](https://www.imagemagick.org/script/download.php))


### How to run this solution?

Clone this repository
```
git clone https://github.com/w-osilva/hell_triangle_challenge.git
```

Run bundler to get dependencies
```
bundle install
```

### Database
Make sure mongo and redis are running
```
mongod --fork --logpath ./log/mongod.log
```
```
redis-server --daemonize yes
```

### Migration
```
rake db:create
rake db:migrate
```


### Queue 
Make sure sidekiq are running
```
sidekiq -C config/sidekiq.yml -d
```

### Task
To import Photos from Webservice
```
rake photo:import
```

### API
Run puma server
```
rails s -p 3000 -b 0.0.0.0 -d
```

Photo list can be viewed in **[http://localhost:3000/photos.json](http://localhost:3000/photos.json)**
