require 'sinatra'
require 'sinatra/reloader'

get "/course/:course/instructor/:instructor" do |course, instructor|
  # set up data for ERB here
  erb :course_roster, layout: :layout
end
