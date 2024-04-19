# [Deploying Sinatra Applications](https://launchschool.com/lessons/26c18317/assignments)

## [Introduction](https://launchschool.com/lessons/26c18317/assignments/cf6f9a67)

## [Configuring an Application for Deployment](https://launchschool.com/lessons/26c18317/assignments/ab12b730)

### [Procfile](https://launchschool.com/lessons/26c18317/assignments/ab12b730)

`web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}`

## [Creating a Heroku Application](https://launchschool.com/lessons/26c18317/assignments/621c4795)

- I hit a wall trying to deploy my Heroku app. The problem was eventually discovered to be me trying to deploy a repo from within a repo.

[thread here](https://launchschool.com/posts/689ace14)


Deploying to Heroku fails because buildpack not compatible with App

Here is my repo.

Here's a list of some things I've tried:

different Heroku stacks.
different Ruby versions.
different build packs.
deleting the app, copying my files to a new directory and starting from scratch.
The git push heroku main command is always returning a variation of the following error message:

```
Enumerating objects: 488, done.
Counting objects: 100% (488/488), done.
Delta compression using up to 4 threads
Compressing objects: 100% (365/365), done.
Writing objects: 100% (488/488), 874.14 KiB | 6.67 MiB/s, done.
Total 488 (delta 219), reused 164 (delta 98), pack-reused 0
remote: Resolving deltas: 100% (219/219), done.
remote: Updated 153 paths from 9fd030d
remote: Compressing source files... done.
remote: Building source:
remote: 
remote: -----> Building on the Heroku-22 stack
remote: -----> Using buildpack: heroku/ruby
remote: -----> App not compatible with buildpack: https://buildpack-registry.s3.amazonaws.com/buildpacks/heroku/ruby.tgz
remote:        More info: https://devcenter.heroku.com/articles/buildpacks#detection-failure
remote: 
remote:  !     Push failed
remote: Verifying deploy...
remote: 
remote: !       Push rejected to sandy-todo-list-app.
remote: 
To https://git.heroku.com/sandy-todo-list-app.git
 ! [remote rejected] main -> main (pre-receive hook declined)
error: failed to push some refs to 'https://git.heroku.com/sandy-todo-list-app.git'
```

I can see my app listed on my Heroku profile, but with the message 'build failed'. You'll see that an atricle is suggested. I've read it haven't found a solution.

Can anyone help?


Victor Paolo Reyes:

Hi, @SandyRodger. That was a bit tricky :sweat_smile:. I tried a bunch of stuff with the buildbacks as well. However, it turns out the problem is that the app isn't the root of your git repo. It wasn't detecting the Gemfile and other files because it was checking at the root path of the repo which is the ../RB175_networked_application. I recommend you copy the app to separate folder outside of an existing repo and then initialize a new repo from there that you would then be linking to your heroku app.

I hope this helps. Cheers :thumbsup:!


Sandy Rodger:

Fantastic - yes that has solved the issue. Thanks for taking the time to help me out! The old git repo inside a git repo issue - when will I learn?

Cheers!


Victor Paolo Reyes:

You're welcome!


## [Summary](https://launchschool.com/lessons/26c18317/assignments/2989ba00)
