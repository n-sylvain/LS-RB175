# Austin Miller's Article: Rack, pt 1

## Content

### [Part 1: What is Rack and what does it do](https://aumi9292.medium.com/rack-part-i-6bb268dde211)

  - [What is Rack?](https://github.com/SandyRodger/RB175_networked_applications/blob/main/Austin_miller_rack_article.md#what-is-rack)
  - [What does it mean for an app to be Rack-based?](https://github.com/SandyRodger/RB175_networked_applications/blob/main/Austin_miller_rack_article.md#what-does-it-mean-for-an-app-to-be-rack-based)
  - [Where it fits in server-side development.](https://github.com/SandyRodger/RB175_networked_applications/blob/main/Austin_miller_rack_article.md#where-does-it-sit-in-server-side-development)
  - [What does Rack do for developers?](https://github.com/SandyRodger/RB175_networked_applications/edit/blob/Austin_miller_rack_article.md#what-does-rack-do-for-developers)
  - [What are the benefits of using Rack?](https://github.com/SandyRodger/RB175_networked_applications/blob/main/Austin_miller_rack_article.md#what-are-the-benefits-of-using-rack)
  - [The #call Method](https://github.com/SandyRodger/RB175_networked_applications/blob/main/Austin_miller_rack_article.md#the-call-method)
  - [What else does Rack need?](https://github.com/SandyRodger/RB175_networked_applications/blob/main/Austin_miller_rack_article.md#what-else-does-rack-need)
  - [Examples of Rack](https://github.com/SandyRodger/RB175_networked_applications/blob/main/Austin_miller_rack_article.md#examples-of-rack)
    - [Minimum Rack](https://github.com/SandyRodger/RB175_networked_applications/blob/main/Austin_miller_rack_article.md#minimum-rack)
    - [HTML Rack](https://github.com/SandyRodger/RB175_networked_applications/blob/main/Austin_miller_rack_article.md#html-rack)
    - [A bug I ran into](https://github.com/SandyRodger/RB175_networked_applications/blob/main/Austin_miller_rack_article.md#a-bug-i-ran-into)
  - [env variable](https://github.com/SandyRodger/RB175_networked_applications/blob/main/Austin_miller_rack_article.md#env-variable)  
  - [A look at the Rack source code](https://github.com/SandyRodger/RB175_networked_applications/blob/main/Austin_miller_rack_article.md#a-look-at-the-rack-source-code)
  - [Part 1: Summary](https://github.com/SandyRodger/RB175_networked_applications/blob/main/Austin_miller_rack_article.md#part-1-summary)
  - [Other notes](https://github.com/SandyRodger/RB175_networked_applications/blob/main/Austin_miller_rack_article.md#other-notes)

### [Part 2: Middleware: what it is and what it can do for your app](https://github.com/SandyRodger/RB175_networked_applications/blob/main/Austin_miller_rack_article.md#austin-millers-article-rack-pt-2)

- [What is Rack Middleware?](https://github.com/SandyRodger/RB175_networked_applications/blob/main/Austin_miller_rack_article.md#what-is-rack-middleware)
- [How does Middleware work?](https://github.com/SandyRodger/RB175_networked_applications/blob/main/Austin_miller_rack_article.md#how-does-middleware-work)
- [Example of middleware](https://github.com/SandyRodger/RB175_networked_applications/blob/main/Austin_miller_rack_article.md#example-of-middleware)
- [Rack builder](https://github.com/SandyRodger/RB175_networked_applications/blob/main/Austin_miller_rack_article.md#rack-builder)
- [Conclusion](https://github.com/SandyRodger/RB175_networked_applications/blob/main/Austin_miller_rack_article.md#conclusion)

## What is Rack?

- A ruby gem that provides an API (Application Programming Interface) between your Ruby program and the application server you're using.
- It facilitates communication between your Rack-based Ruby app and the application server you're working with (which could be WEBrick, Puma, Passenger, Unicorn,Thin ...)
- You type in a URL or click a link and this happens:

<img width="670" alt="Screenshot 2023-06-19 at 17 34 02" src="https://github.com/SandyRodger/RB175_networked_applications/assets/78854926/7ab61c2e-6aa7-4031-86ee-32ebc0669a1e">

## What does it mean for an app to be rack-based?

- It's a Rack-based app if it follows a set of specifications that mean Rack knows what to do with it:
  - The application must define a `call` method, which takes 1 parameter, usually called `env`.
  - This `call` method will return an array containing 3 objects:
    -  a String or Int that is the status code (ie `200` for OK)
    -  a Hash object that holds key-value pairs of content headers and their values
    -  an object that responds to Enumerable#each and holds the body of the response.

<img width="719" alt="Screenshot 2023-06-21 at 08 00 56" src="https://github.com/SandyRodger/RB175_networked_applications/assets/78854926/cd28a226-6a36-4252-914c-e722b2854655">

## Where does it sit in server-side development?

- Between the application server and the application.

## What does Rack do for developers?

- Sending requests from the Client to the server:
  - Rack accepts HTTP requests.
  - Formats them into Ruby Datas structures that are easier to handle.
- Sending responses from app-server to app:
  - Takes the return value of your Ruby program (? A program I've written on the app-server I guess?)
  - Spits out some HTTP compliant text to be sent as a HTTP response.
- It looks like this:

<img width="682" alt="Screenshot 2023-06-20 at 16 06 37" src="https://github.com/SandyRodger/RB175_networked_applications/assets/78854926/a48edfad-ba4b-4778-a861-707cb1216373">

## What are the benefits of using Rack?

- Rack frees up your application to focus on:
  - core business logic (?)
    - Making server side changes
    - generating dynamic content.
- ... by taking care of lower level tasks, like handling http requests/responses.
- It provides a standardized way for servers and apps to communicate. It doesn't matter which app-server you're using, the configuration file stays the same.

## The #call Method

- When call is envoked, the object passed to `env` will be a hash. The hash will have all the information about the incoming request. (`HTTP` headers and other environment variables).
- The return value of `call` is a 3 object array used to form a response status, response headers and a response body.
- This response then becomes the HTTP response for the client.

## What else does Rack need?

- What to run and how to run it.
  - Run a rackup `config.ru` file.
  - or `require 'rack'` and invoke `Rack::Handler::WEBrick.run`

## Examples of Rack

### Minimum Rack:

```ruby
require 'rack'
class MyApp
  def call(env)
    ['200', { "Content-Type" => "text/plain" }, ["hello world"]]
  end
end
Rack::Handler::WEBrick.run MyApp.new
```

- Hiccup: This code-along exercise says to run this file and cause a server on port 8080  to start listening for incoming requests from a client. So one then types `http://www.localhost:8080` into a browser and 'hello world' appears. This works with Google chrome browser, but not with Safari. 

### HTML Rack

```ruby
require 'rack'

class MyApp
  def call(env)
    body = "<h2>Hello in Style!</h2>"
    ['200', {"Content-Type" => "text/html"}, [body]]
  end
end

Rack::Handler::WEBrick.run MyApp.new
```

### A bug I ran into

- It seems that Rack/Handler has been deprecated, so when i tried to run the `myapp.rb` file I got an error message.
- It was solved by using Rack 2.2.0 rather than the latest Rack 3.0.8.
- The whole process is documented in [this discussion entry](https://launchschool.com/posts/98d38f95)

## env variable

```ruby
require 'rack'
class MyApp
  def call(env)
    ['200', { "Content-Type" => "text/plain" }, [env.to_s]]
  end
end
Rack::Handler::WEBrick.run MyApp.new
```

- The code above prints out the `env` variable:

<img width="1417" alt="Screenshot 2023-09-18 at 10 18 19" src="https://github.com/SandyRodger/RB175_networked_applications/assets/78854926/88ec98fb-591c-4803-829b-05b7e8cba2ef">


- This is the HTTP request broken down.
- It is also information that rack appends to the HTTP request. (Everything from "rack.version"=>[1, 3])
- The "PATH_INFO" and "REQUEST_METHOD" are the most useful pieces of info for you as the dev.
  - "PATH_INFO" shows the path added to the URL after the `hostname`.
  - "REQUST_METHOD" can be used to see if the user is requesting a server-side change or just requesting a resource.

## A look at the Rack source code

-  This section looks at the rack source code on Github. Specifically the `WEBrick` module within `Rack::Handler`. Confusingly, this WEBrick module inherits from a WEBrick class somewhere up the inheritance chain.

<img width="598" alt="Screenshot 2023-06-26 at 22 06 17" src="https://github.com/SandyRodger/RB175_networked_applications/assets/78854926/b2e3a56d-5d7d-4f32-9cc0-cda9ba8d30ff">

- So the `::run` method takes an `app` and an `options` hash argument.
- The `options` hash lets us specify a port and host-name other than the default.
- Different parts tackle different tasks, like opening and closing sockets. I'm not going to try and learn this completely because I think it's slightly too granular for the scope of my course.

## Part 1: Summary

- Rack is a Ruby gem that sits between the app and the app-server.
- Rack based apps.
- The `call` method, with its `env` argument.
- We sent a response from our app to the browser (client).
- We looked down another layer of abstraction to the source code to see a bit more of how Rack is doing behind the scenes.
- In part 2 of the article we will look at how we can use Rack to stack multiple modular apps on top of each other.

## Other notes

- [A comparison of (Rack) web-servers for Ruby web applications](https://www.digitalocean.com/community/tutorials/a-comparison-of-rack-web-servers-for-ruby-web-applications)
    - This started good, but got into the weeds a bit talking about the advantages of different web-servers, like Puma, Thin and Unicorn. I found it too vague to be meaningful to me right now. Probably because I don't know enough about how web-servers work concretely.

# [Austin Miller's Article: Rack, pt 2](https://aumi9292.medium.com/rack-part-ii-5dc89e9d89d8)

  - What qualifies a Ruby application to be a Rack middleware.
  - What middlewares can do for your application.
  - Two Rack middleware applications for my_app.rb.

## What is Rack Middleware?

- Rack lets you chain Rack-based classes together.
- It also works with other servers to handle necessary socket programming to start a server.
- You can write your own Rack-based app or you can take a "middleware" from a rack library.
- Rack middleware allows devs to build-in functionality to their apps (ie. logging-in authentication or stopping spam) before they even start coding their app.
- Kind of like a Ruby gem ?
- Here's a list of some:

<img width="648" alt="Screenshot 2023-06-26 at 22 33 08" src="https://github.com/SandyRodger/RB175_networked_applications/assets/78854926/2c169797-3a85-4222-b238-8f10b3182769">

## How does Middleware work?

- The `call` method has to return an array with 3 objects, used to form:
  -  the response status.
  -  the response headers.
  -  the response body.
- Classes that satisfy this requirement can be chained together.
- You can have many small modular apps that can be chained together to make a middleware stack.

## Example of middleware

```ruby
require 'rack'
class MyApp
  def call(env)
    ['200', { "Content-Type" => "text/plain" }, ["hello world"]]
  end
end
class FriendlyGreeting
  def initialize(app)
    @app = app
  end
  def call(env)
    body = @app.call(env).last
    [
      '200', 
      { "Content-Type" => "text/plain" }, 
      body.prepend("A warm welcome to you!\n")
    ]
  end
end
Rack::Handler::WEBrick.run FriendlyGreeting.new(MyApp.new)
```

- Middleware applications must have an initialize method that takes one argument.
- When `::new` is invoked on `FriendlyGreeting`, an instance of that app one level down the chain (so the return value of `MyApp.call` ?) will be passed in.
- We invoke `Array#last` to access the 3rd element of the return value of `MyApp#call`, which is the response body. Then we prepend it with another string and a new line.
- OK, so we create an instance of the `FriendlyGreeting` class, passing in a `MyApp` object as an argument and pass all that as an argument to the `::WEBrick.run` method. Simple method-chaining:
  - `MyApp.new` --> `FriendlyGreeting.new` --> `WEBrick`

## Rack builder

- Rack::Builder is a DSL (Domain Specific Language).
- It gives us the `use` method to more concisely encorporate middlewares.
- The following example shows how messy it gets when you add a bunch of middlewares without Rack::Builder:

```
class MyApp
  def call(env)
    ['200', { "Content-Type" => "text/plain" }, ["hello world"]]
  end
end
class FriendlyGreeting
  def initialize(app)
    @app = app
  end
  def call(env)
    body = @app.call(env).last
    [
      '200', 
      { "Content-Type" => "text/plain" }, 
      body.prepend("A warm welcome to you!\n")
    ]
  end
end
class Wave
  def initialize(app)
    @app = app
  end
  def call(env)
    body = @app.call(env).last
   
    [
     '200', 
     { "Content-Type" => "text/plain" }, 
     body.prepend("Wave from afar!\n")
    ]
  end 
end
Rack::Handler::WEBrick.run Wave.new(FriendlyGreeting.new(MyApp.new))
```

- To use `Rack::Builder` we:
  - Create a `config.ru` file in the same directory as our `myapp.rb` file:

```ru
#config.ru
require_relative "myapp"
use Wave
use FriendlyGreeting
run MyApp.new
```

  - define your classes in a ruby file:

```ruby
#myapp.rb
#require 'rack'
class MyApp
  def call(env)
    ['200', { "Content-Type" => "text/plain" }, ["hello world"]]
  end
end
class FriendlyGreeting
  def initialize(app)
    @app = app
  end
  def call(env)
    body = @app.call(env).last
    [
      '200', 
      { "Content-Type" => "text/plain" }, 
      body.prepend("A warm welcome to you!\n")
    ]
  end
end
class Wave
  def initialize(app)
    @app = app
  end
  def call(env)
    body = @app.call(env).last
    [
     '200', 
     { "Content-Type" => "text/plain" }, 
     body.prepend("Wave from afar!\n")
    ]
  end 
end
```

- and run the `config.ru` file with `rackup config.ru`.

## Conclusion

- Rack is the 9th most popular Ruby Gem. It does this:
  - Abstracts low-level tasks:
    - Parsing HTTP requests
    - Formatting the return value of your app to HTTP
  - Generalizes application-to-server communication:
    - All Rack based apps (whether written in Sinatra, rails, etc) can establish socket connections (Puma, WEBrick, Passenger).
  - Provides an architechture for using modular pieces of functionality.


