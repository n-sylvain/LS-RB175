require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

before do
  @contents = File.readlines("data/toc.txt")
end

helpers do
  def in_paragraphs(text)
    text.split("\n\n").each_with_index.map do |line, index|
      "<p id=paragraph#{index}>#{line}</p>"
    end.join
  end

  def highlight(text, term)
    text.gsub(term, %(<strong>#{term}</strong>))
  end
  
end

not_found do
  redirect "/"
end

get "/" do
  @title = "The Adventures of Sherlock Holmes"

  erb :home
end

get "/chapters/:number" do
  number = params[:number].to_i
  chapter_titles = @contents[0..-2]
  redirect "/search" if number == 13
  @title = " " + chapter_titles[number.to_i - 1]
  @chapter = File.read("data/chp#{number}.txt")

  redirect "/" unless (1..@contents.size).cover? number
  
  erb :chapter
end

get "/show/:name" do
  params[:name]
end

def each_para(contents, query)
  contents.split("\n\n").select do |para|
    para.include?(query)
  end
end

def each_chapter
  @contents.each_with_index do |name, index|
    number = index + 1
    next if number > 12
    contents = File.read("data/chp#{number}.txt")
    yield number, name, contents
  end
end

def chapters_matching(query)
  results = []

  return results unless query

  each_chapter do |number, name, contents|
    matches = {}
    contents.split("\n\n").each_with_index do |paragraph, index|
      matches[index] = paragraph if paragraph.include?(query)
    end
    results << {number: number, name: name, paragraphs: matches} if matches.any?
  end

  results
end

get "/search" do
  @results = chapters_matching(params[:query])

  erb :search
end