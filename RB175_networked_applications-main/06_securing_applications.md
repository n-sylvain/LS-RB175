# [Securing Applications](https://launchschool.com/lessons/31df6daa/assignments)

## [Introduction](https://launchschool.com/lessons/31df6daa/assignments/b8320feb)

- Many devs prefer Sinatra over larger frameworks like Rails. This is because it's a much smaller library. So it's simpler, but the dowside is you have to do things manually that a larger system may have taken care of.

|  | Smaller frameworks (like Sinatra)| Larger Frameworks (like Ruby on Rails| 
| :--- | :---: | :---: | 
|Pros| Much smaller library | does tasks for you automatically, like escaping html|
|Good if...| you don't need all the functionality provided by Rails|
|because...| there's less to learn in order to be productive|
| downside is... | they sometimes require you to do things manually like escaping html| |

### Keeping HTML safe

- You're app is only as secure as the code running in the browser when someone uses it.
- This means primarily the HTML, CSS and JavaScript + 3rd party libraries like jQuery or analytic packages.
- Webpages build HTML dynamically, which means there are lots of opportunities for someone to influence the code that is written on the page.
- If they can modify the code oin the page then they have all the access to steal data or even credentials.

### An Example

- Enter a todo with the following text `<script>alert("This code was injected!");</script>Pizza`.
- This means:
  - A) The JavaScript tag is being evaluated
  - B) When you click `ok` the page goes back to normal. So if JavaScript hadn't announced itself we wouldn't have know it was there.
- Doing the same thing for the lists-page breaks the page.

## [Sanitizing HTML](https://launchschool.com/lessons/31df6daa/assignments/d98e4174)

- To understand what these script tags are doing we need to look at the HTML templates where they are bneing rendered.
- Here it is:

```html
<% if todo[:completed] %>
  <li class="complete">
<% else %>
  <li>
<% end %>
  <form action="/lists/<%= @list_id %>/todos/<%= index %>" method="post" class="check">
    <input type="hidden" name="completed" value="<%= !todo[:completed] %>" />
    <button type="submit">Complete</button>
  </form>
  *** <h3><%= todo[:name] %></h3> ***
  <form action="/lists/<%= @list_id %>/todos/<%= index %>/destroy" method="post" class="delete">
    <button type="submit">Delete</button>
  </form>
</li>
```
- With a normal todo entry it would render the following:

```html
<li>
  <form action="/lists/0/todos/0" method="post" class="check">
    <input type="hidden" name="completed" value="false" />
    <button type="submit">Complete</button>
  </form>
  <h3>Pizza</h3>
  <form action="/lists/0/todos/0/destroy" method="post" class="delete">
    <button type="submit">Delete</button>
  </form>
</li>
```

- but with the malicious script-tag we see this:

```html
<li>
  <form action="/lists/0/todos/0" method="post" class="check">
    <input type="hidden" name="completed" value="false" />
    <button type="submit">Complete</button>
  </form>
  <h3><script>alert("This code was injected!");</script>Pizza</h3>
  <form action="/lists/0/todos/0/destroy" method="post" class="delete">
    <button type="submit">Delete</button>
  </form>
</li>
```

- These are serious security risks and in the right place can cause wide-spread damage.

### Escaping HTML

- The solution is to escape any values that come from an untrusted source (ie all-users).
- This means replacing certain characters in the text with html entities that the browser won't interpret as code.
- This includes quotes, greater and less than operators and more.
- There is a built in method that will handle this for us. The Rack library, which Sinatra is built on top of provides this method: `Rack::Utils.escape_html`

```ruby
helpers do
  def h(content)
    Rack::Utils.escape_html(content)
  end
end
```

- This is available anywhere in a Sinatra app, but it can be nice to make a helper method for it:
```ruby
helpers do
  def h(content)
    Rack::Utils.escape_html(content)
  end
end
```

- Which can be invoked in a view template like this:

```html
<h3><%=h todo[:name] %></h3>
```

### A more thorough approach

- Using view helpers to manually escape values can be helpful, but it's impractical to remember to do this always and this type of security concern is a common problem online.
- To combat this many libraries automatically escape all output.
- To enable this, simple add the following code to your `todo.rb` file :

```todo.rb
configure do
  set :erb, :escape_html => true
end
```

- This works a little too well as it escapes all the code in our site.
- To get around this we must change `<%=` to `<%==` at the palces we want to disable auto-escaping.
- This is where we yield to the template and where we print out our header links:

```html
<!doctype html>
<html lang="en-US">
  <head>
    <title>Todo App</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="//fonts.googleapis.com/css?family=PT+Sans">
    <link rel="stylesheet" href="/stylesheets/whitespace-reset.css">
    <link rel="stylesheet" href="/stylesheets/application.css">
    <script src="/javascripts/jquery-2.1.4.js"></script>
    <script src="/javascripts/application.js"></script>
  </head>
  <body>
    <header>
      <h1>Todo Tracker</h1>
      <div class="actions">
        <%== yield_content :header_links %>
      </div>
    </header>

    <% if session[:error] %>
      <div class="flash error">
        <p><%= session.delete(:error) %></p>
      </div>
    <% end %>

    <% if session[:success] %>
      <div class="flash success">
        <p><%= session.delete(:success) %></p>
      </div>
    <% end %>

    <main>
      <%== yield %>
    </main>
  </body>
</html>
```

## [Handling Bad Input](https://launchschool.com/lessons/31df6daa/assignments/cb2ef1d2)

- Trying to access the 15th list at `http://localhost:4567/lists/15` raises an exception. Here I have to create a path that redirects this exception to the homepage and presents a flash-message.

- I need to come back to this, my brain is dead.

## [HTTP Methods and Security](https://launchschool.com/lessons/31df6daa/assignments/a64adb5b)

- Video [5:16]
- Not a lot of differentce in HTTP methods' security levels.
- Charles - HTTP debugging proxy. It allows you to see what data is being sent.
- [3:10] HTTPs
- POST v GET

Practice Problems

1. Is using POST as the HTTP method for a request more secure than GET? Why or why not?

No, POST and GET are equally insecure in HTTP because the parameters of the request can be read by anyone listening in. For GET requests these parameters are in the URL and for POST requests they are in the message body. But both of these places are visible to external observers. This is only avoided with HTTPS.

2. How can a web application be secured so that any data being sent between the client and server can not be viewed by other parties?

Serving the aplication over HTTPS.

## [Quiz](https://launchschool.com/quizzes/b8cf9979)

| Question | My answer | correct? | Correction |
| :--- | :---: | :---: | :---: |
|1.|
|2.| 
|3.| 
|4.| 
|5.| 
|6.| 
|7.| 
|8.| 
|9.| 
|total|9/9 (100%)|
