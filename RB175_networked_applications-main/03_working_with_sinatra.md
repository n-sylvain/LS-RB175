# [Working with Sinatra](https://launchschool.com/lessons/c3578b91/home)

## 1	[Introduction](https://launchschool.com/lessons/c3578b91/assignments/b0bee199)

- Sinatra is a web-development framework. Its purpose is to help web-developers speed up development by automating common tasks.
- This is great if you have experience and know what these common tasks are, but if you don't it's confusing.
- For the following section we'll be building on what you learnt in [Packaging code into a project](https://launchschool.com/lessons/2fdb1ef0/assignments) and the [Ruby Core Tools book](https://launchschool.com/books/core_ruby_tools).

## 2	[Rack](https://launchschool.com/lessons/c3578b91/assignments/2a32fe08)

- Not to be confused with Rake.

### Rack applications

#### WEBrick

- We don't want to use our own TCP server to process requests because:
  -  There are more common/robust web-servers in existence already.
-  One that comes with older versions of Ruby is WEBrick.
-  So just like using something from the `Array` class in Ruby, let's use WEBrick instead of creating our own thing.
-  Add the following statement to your Gemfile and run `bundle install`:
  -  `gem 'webrick'`

- Connecting and working with WEBrick is a pain in the ass - make it easier with Rack.
- Rack is a library that helps connecting to WEBrick.
- Rack is also a generic interface that helps devs to connect to web-servers. (it's not just for WEBrick).
- So we're basically using Rack instead of our Ruby code and WEBrick instead of our TCP server.

HERE'S A SENTENCE I DON'T UNDERSTAND:

"When working with Rack applications our entire server is comprised of the Rack application and the web server (which is probably WEBrick, which comes with your Ruby installation)".
                        
SO, I'LL COME BACK TO THAT.

- Most Devs would never write a Rack application except in the simplest of situations. We'll go through it here for teaching purposes.

## Articles:

### [My notes on Austin Miller's rack article on Medium](https://github.com/SandyRodger/RB175_networked_applications/blob/main/Austin_miller_rack_article.md)

### [`What is Rack in Ruby/Rails?` blog](http://blog.gauravchande.com/what-is-rack-in-ruby-rails)

- Your browser sends a HTTP request to the server.
- The server has 'rails' loaded. It would hand the HTTP request to Rails, but Rails wouldn't understand, so we first pass it to Rack.
- Server passes the HTTP request to Rails which formats this:

```
GET /users HTTP/1.1
Host: localhost
Connection: close
```

- into this:

```
env = {
  'REQUEST_METHOD' => 'GET',
  'PATH_INFO' => '/users',
  'HTTP_VERSION' => '1.1',
  'HTTP_HOST' => 'localhost',
  ...
  ...
}
```

- this `env` is then sent to the app.
- The app does its work and returns its response to the server as a 3 object array:

```
[
  200,
  {
    'Content-Length' => '25',
    'Content-Type' => 'text/html'
  },
  [
    '<html>',
    '...',
    '</html>'
  ]
]
```

- The server can take this response and format it into a response to the client.

- For the app to be a Rack app, it has to contain the following method:

```
class App
  def call(env)
    [
      200,
      { 'Content-Length' => 25, 'Content-Type' => 'text/html' },
      [ "<html>", "...", "</html>" ]
    ]
  end
end
```

- Rails contains this method, which is why is works with Rack

- [An excellent video on Rack](http://railscasts.com/episodes/151-rack-middleware?autoplay=true)
- `rake middleware` command

### Growing your own web Framework on rack

### [pt 1](https://launchschool.com/blog/growing-your-own-web-framework-with-rack-part-1)

- Here is what you need to make your Ruby code into a Rack application:
  - Create a “rackup” file: this is a configuration file that specifies what to run and how to run it. A rackup file uses the file extension `.ru`.
  - The rack application we use in the rackup file must be a Ruby object that responds to the method call(env). The call(env) method takes one argument, the environment variables for this application.
  - The call method always returns an array, containing these 3 elements [1]:
    - Status Code: represented by a string or some other data type that responds to to_i.
    - Headers: these will be in the form of key-value pairs inside a hash. The key will be a header name and the corresponding value will be the value for that header.
    - Response Body: this object can be anything, as long as that object can respond to an each method. An Enumerable object would work, as would a StringIO object, or even a custom object with an each method would work. The response should never just be a String by itself, but it must yield a String value.
- A bug:

The Puma file was being given 2 arguments but it expected 1. This was because the 2nd parameter was defined as `**options`, so when i deleted the two asterisks it ran fine. It felt great to catch that. Maybe the difference is to be found in the differing versions of Ruby? I'll ask Olly.
### [pt 2: routing](https://launchschool.com/blog/growing-your-own-web-framework-with-rack-part-2)

- We build up the basic app by introduciing 'routing'. This means adding other pages to our application.
- When the browser's path is...
  - `/` we return 'hello world'.
  - '/advice' we return a piece of advice.
  - anything else a '404' error code.
### [pt 3: seperating application logic from viewing code](https://launchschool.com/blog/growing-your-own-web-framework-with-rack-part-3)

- This section is about separating the tasks of our core routing logic and our views. This means:
  - Introducing the `ERB` library, which helps us turn Ruby into HTML.
  - Updating our app code to include view templates.

- View Templates
  - We need somewhere to store/handle the code relating to displaying.
  - This is called a 'view template' and is kept in a separate file that allows us to do some pre-processing on the server-side in a programming language and then translate that programming code into a string to return to the client (usually as HTML).
  - At this point we are including HTML within the string response of our program. The string has string interpolation within it, so its content is dynamic.
  - If we want to have 'separation of concern' - ie. keeping things in their own boxes - then read on...
- ERB
  - Embedded Ruby is a templating library.
  - To use this we need:
    - `require 'erb'`
    - Create an ERB template object and pass in a string using the special syntax.
    - Invoke the ERB instance method `result` which outputs pure HTML.
  - It allows us to embed Ruby directly into HTML.
  - ERB takes a special syntax mixing Ruby and HTML and outputs a pure HTML string.
  - In IRB this looks like this:

![Screenshot 2023-09-18 at 11 45 43](https://github.com/SandyRodger/RB175_networked_applications/assets/78854926/8a4de9c7-1609-4086-b95b-a6f510303eca)

  - Notice the new ERB template object is a mixture of Ruby and HTML. We use `<%= %>` to let ERB know how to process this Ruby embedded in the string.
    - With the `=` sign evaluates the Ruby code and includes the return value (`<%= names.sample %>`).
    - Without the `=` sign just evaluates the code (<% log_time_method %>)
  - ERB can process entire files, not just strings. These files end with a `.erb` extention, and use the same tags to embed Ruby.
  - For example:
```ERB
<% names = ['bob', 'joe', 'kim', 'jill'] %>
<html>
  <body>
    <h4>Hello, my name is <%= names.sample %></h4>
  </body>
</html>
```
  - Which could be run thus:
```ruby
require 'erb'
template_file = File.read('example.erb')
erb = ERB.new(template_file)
erb.result
```

  - The result looks like this:

  `"\n<html>\n  <body>\n    <h4>Hello, my name is bob</h4>\n  </body>\n</html>"`

- Adding in View Templates

- We create a view template called `index.erb` within a `views` folder containing the following:
```
<html>
  <body>
    <h2>Hello World!</h2>
  </body>
</html>
```

- So that the main webpage renders to a h2.

### [pt 4 - cleaning up and optimising the app](https://launchschool.com/blog/growing-your-own-web-framework-with-rack-part-4)

- Cleaning up the #call method
- Adding more View Templates
- Refactoring and streamlining our application.
- Start of a framework.
- Conclusion.  

## [3. Sinatra Documentation](https://sinatrarb.com/intro.html)

- I don't really know what to do with this web-page. I'll come back to it.

## [4. Preparations](https://launchschool.com/lessons/c3578b91/assignments/80745ebb)

- Building a small, mobile-friendly e-book using Sinatra.

### Sinatra and Web Frameworks

- This section describes how TCP, Rack, WEBrick and Sinatra interact.
- Sinatra is a Rack-based development framework.
- Rack-based means that it uses Rack to connect ot a web-server, such as WEBrick.
- Sinatra also provides conventions for where to place your application-code.
- It comes with many features to make my job easier, such as:
  - routing.
  - view-templates.
  - and many more.

![Screenshot 2023-09-20 at 08 41 05](https://github.com/SandyRodger/RB175_networked_applications/assets/78854926/c6b55a25-ffa9-4f2a-9a6a-26ab2a0598e0)

- At its core this is just some Ruby code connecting to a TCP server, handling requests and sending back responses in HTTP-compliant strings. 

## [How Routes Work](https://launchschool.com/lessons/c3578b91/assignments/e17701ee)

- Sinatra provides a DSL for defining 'routes', which are how a dev maps a URL pattern to some Ruby code.
- For example:

``` ruby
require "sinatra"
require "sinatra/reloader"

get "/" do
  File.read "public/template.html"
end
```

- In this example we require Sinatra and sinatra/reloader, which causes the app to reload its files every time we load a page. This makes development smoother.
- `get "/" do` states a route that matches the URL "/". When a user visits that path on the app, Sinatra will execute the body of the block.
- The string returned by the `File.read` method is then returned by the block and sent by Sinatra to the browser in response to the `get` request for the `/` route.

- [An interesting page explaining files](https://launchschool.com/gists/630c1024)

## [Rendering Templates](https://launchschool.com/lessons/c3578b91/assignments/d6969b5b)

- Here we attempt to render a template, with dynamic values, rather than a static file.
- Templates (AKA 'view-templates') are files that contain text that is converted into HTML before being sent to a user's browser in a response.
- There are different templating language, we'll use ERB.
- This section explains ERB, but we've already looked at ERB [here](https://github.com/SandyRodger/RB175_networked_applications/blob/main/03_working_with_sinatra.md#pt-3-seperating-application-logic-from-viewing-code). It seems to basically be string interpolation.
- ERB is also the default templating language for Ruby on Rails.
- An example of ERB printing a dynamic value: `<h1><%= @title %></h1>`. Without the `=` the code is run, but the return value not printed.

## [Table of Contents](https://launchschool.com/lessons/c3578b91/assignments/7ef83dcf)

- I peaked at the final two solutions.

## [Adding a Chapter Page](https://launchschool.com/lessons/c3578b91/assignments/bc383885)

- Peaked at all the solutions...

## [Code Challenge: Dynamic Directory Index](https://launchschool.com/lessons/c3578b91/assignments/d703af4a)

- ...

## [Using Layouts](https://launchschool.com/lessons/c3578b91/assignments/371514e7)

- I need to go over this again for sure.

## [Route Parameters](https://launchschool.com/lessons/c3578b91/assignments/687874590)

- yup

## [Before Filters](https://launchschool.com/lessons/c3578b91/assignments/801b30c3)

- tick

## [View Helpers](https://launchschool.com/lessons/c3578b91/assignments/517ff8ae)

- done

## [Redirecting](https://launchschool.com/lessons/c3578b91/assignments/a648853a)

- 

## [Adding a Search Form](https://launchschool.com/lessons/c3578b91/assignments/f2358cb8)

-

## [Improving Search](https://launchschool.com/lessons/c3578b91/assignments/13a608d9)

-

## [Code Challenge: Users and Interests](https://launchschool.com/lessons/c3578b91/assignments/36890ee9)

- 

## [Server-side vs. Client-side Code](https://launchschool.com/lessons/c3578b91/assignments/8b735100)

| File-type | Server-side or client-side? | Correct? | Explanation|
| :--- | :---: | :---: | :---: |
|Gemfile| I think client side,. because you have to install gems.|no| **Server-side** This file is used by Bundler, the Ruby dependency management system, to install libraries needed to run the program.|
|Ruby file (`.rb`)|Client side |no|**Server-side** These files are the core of a Sinatra application. The code within them runs on the server while handling incoming requests.
|Stylesheet (`.css`)|I'm guessing Server side. but i couldn't say why. |no|**Client-side.** The code within these files is interpreted by the web browser (a client) as instructions for how to display a web page.
|Javascript (`.jss`| server-side |no|**lient-side. The code within these files is evaluated by the JavaScript interpreter within a web browser (a client) to add behavior to a web page**
|View Templates (`.erb`)| server-side|yes | **Server-side**. The Ruby code within these files is evaluated on the server to generate a response that will then be sent to the client.

But what about the HTML tags within a view template? Aren't those client-side code?

This is a common point of confusion, as these files contain both client-side code (HTML tags) and server-side code (Ruby). However, since they must be processed by a program on the server before being sent to the client, the ERB templates we've used in this course are considered to be server-side code.

## [Optional: A Quick Analysis of How Sinatra Works](https://launchschool.com/lessons/c3578b91/assignments/debd1439)

- skip for now

## [Summary](https://launchschool.com/lessons/c3578b91/assignments/d46251f7)

- 

## [Quiz](https://launchschool.com/lessons/c3578b91/assignments/0a01eeeb)

| Question | My answer | correct? | Correction |
| :--- | :---: | :---: | :---: |
|1.| A, C, D | yes | 
|2.|C | yes | 
|3.|C |  also B |  any name that ends with .ru is acceptable. | 
|4.|A,C, D| not C | The second element contains the response headers, not the request headers.|
|5.| B, C | also A | Routes are Ruby methods provided by Sinatra that typically use HTTP method names such as get, put, and delete.|
|6.|C, D | not C, but B| get, put, delete, and options all correspond to HTTP methods and are methods in Sinatra. You can use them all, as well as post, patch, link, and unlink, to define routes.|
|7.|C| also D|  The specified path matches both patterns. In D, :type matches any single word in that position.
|8.|B| also A|A. 3456 matches the :product_id parameter, while meats matches the :category parameter. Sinatra doesn't include query strings when checking for a matching route. B. xyzzy matches the :product_id parameter (note that Sinatra doesn't care whether the ID is numeric).|
|9.| A|yes|
|10.|B| D| the 2nd entry doesn't ahve an `=` sign.|
|11.|B,D|yes|
|12.|A, D| yes|
|13.|A, B| A, D|
|14.|C, D| A,C,D|params can take strings as arguments.|
|15.|D|yes|
|16.|C|D|You typically call redirect from the route's code, not the template file.|
|17.|A|D| Sinatra invokes the not_found route to process paths for which there is no route.|
|18.|A, B, C| B, C| `redirect` must take an argument to know where to redirect to.|
|19.|C, D| A, D|Redirection requires both a `Location` header and a status code. Sinatra doesn't load the redirected page itself; the browser must request it|
|20.|C| yes|
|total|7/20 (35%)


|  | Once | Twice | Thrice | Comprehension | Retention
| :--- | :---: | :---: | :---: | :--- | :---
|1	Introduction|	19.6.23|
|2	Rack	| 19.6.23|19.9.23|
|3	Sinatra Documentation|19.9.23|
|4	Preparations|20.9.23|
|5	How Routes Work|20.9.23|
|6	Rendering Templates|20.9.23|
|7	Table of Contents|20.9.23|
|8	Adding a Chapter Page|20.9.23|
|9	Code Challenge: Dynamic Directory Index| 21.9.23
|10	Using Layouts|22.9.23|
|11	Route Parameters|22.9.23|
|12	Before Filters|22.9.23|
|13	View Helpers|23.9.23|
|14	Redirecting|23.9.23|
|15	Adding a Search Form|23.9.23|
|16	Improving Search|24.9.23|
|17	Code Challenge: Users and Interests|26.9.23|
|18	Server-side vs. Client-side Code|26.9.23|
|19	Optional: A Quick Analysis of How Sinatra Works|26.9.23|
|20	Summary|26.9.23|
|21	Quiz|26.9.23|
