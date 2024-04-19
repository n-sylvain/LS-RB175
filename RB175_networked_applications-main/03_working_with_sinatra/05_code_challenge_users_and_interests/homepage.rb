require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "yaml"

before do
  @contents = YAML.load_file("data/users.yaml")
  @contents_arr = []
  @users_count = 0
  @interests_count = 0
  @contents.each do |name, hash|
    @users_count += 1
    sub_arr = [name]
    hash.each do |_, content|
      @interests_count += content.size if content.is_a?(Array)
      sub_arr << content
    end
    @contents_arr << sub_arr
  end
end

get "/" do
  redirect "/users_names"  
end

get '/users_names' do
  erb :users_names
end

get '/data/profiles/:name' do
  name = params[:name]
  @name = File.read("data/profiles/#{name}").split[1]
  @email= File.read("data/profiles/#{name}").split[3]
  @interests = File.readlines("data/profiles/#{name}")[-3..]

  erb :user_page
end

def count_interests

end