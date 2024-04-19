# [Project: File-based CMS](https://launchschool.com/lessons/ac566aae/home)

## [Introduction](https://launchschool.com/lessons/ac566aae/assignments/79584152)

## [Getting Started](https://launchschool.com/lessons/ac566aae/assignments/d20ebf86)

<img width="1440" alt="Screenshot 2023-10-14 at 10 00 30" src="https://github.com/SandyRodger/RB175_networked_applications/assets/78854926/00c98678-29f3-4880-99f1-7564ccfd289e">

Where my implementation differed from LS:

They ran the app with `bundle exec ruby cms.rb`, where I just used `ruby app.rb`

## [Adding an Index Page](https://launchschool.com/lessons/ac566aae/assignments/c123de3d)

<img width="1440" alt="Screenshot 2023-10-14 at 10 28 54" src="https://github.com/SandyRodger/RB175_networked_applications/assets/78854926/61853da0-4008-49e1-a59e-e2c95d526208">


Where my implementation differed from LS:

- I put the files in a `public` directory. Not cool.
- Moved all with `mv public/* data/*`

- LS used `root = File.expand_path("..", __FILE__)`
- I used `@files = Dir.entries("public/").select {|file| !file.split("").all?(".") }`

BUG:

- I coiuldn't get the webpage to respond to my changes, until i realized that if a `layout.erb` file exists, the program will default to that, even though you specify another `erb` page (here `index.erb`) in the path. Made more confusing by the inspector calling the page 'index'.

## [Viewing Text Files](https://launchschool.com/lessons/ac566aae/assignments/2ac6062e)

- My soluton was pretty different but we got there in the end.

## [Adding Tests](https://launchschool.com/lessons/ac566aae/assignments/242be636)

- 

## [Handling Requests for Nonexistent Documents](https://launchschool.com/lessons/ac566aae/assignments/7748eb7b)

## [Viewing Markdown Files](https://launchschool.com/lessons/ac566aae/assignments/98d2fce2)

### Redcarpet Gem

## [Editing Document Content](https://launchschool.com/lessons/ac566aae/assignments/035eb4d6)



## [Isolating Test Execution](https://launchschool.com/lessons/ac566aae/assignments/a23f0109)


## [Adding Global Style and Behavior](https://launchschool.com/lessons/ac566aae/assignments/84acfc0c)


## [Sidebar: Favicon Requests](https://launchschool.com/lessons/ac566aae/assignments/ba2a5d8d)


## [Creating New Documents](https://launchschool.com/lessons/ac566aae/assignments/e1e7cf2a)


## [Deleting Documents](https://launchschool.com/lessons/ac566aae/assignments/79fccabc)


## [Signing In and Out](https://launchschool.com/lessons/ac566aae/assignments/e92bd5bc)


## [Accessing the Session While Testing](https://launchschool.com/lessons/ac566aae/assignments/52d6d56d)


## [Restricting Actions to Only Signed-in Users](https://launchschool.com/lessons/ac566aae/assignments/cf4382fe)


## [Storing User Accounts in an External File](https://launchschool.com/lessons/ac566aae/assignments/c745b2fd)


## [Storing Hashed Passwords](https://launchschool.com/lessons/ac566aae/assignments/537af113)


## [Next Steps](https://launchschool.com/lessons/ac566aae/assignments/193b81e4)


## [A Note about Security](https://launchschool.com/lessons/ac566aae/assignments/5f01c374)


## [Summary](https://launchschool.com/lessons/ac566aae/assignments/ad1cecd7)


## [Quiz](https://launchschool.com/lessons/ac566aae/assignments/64db5708)
