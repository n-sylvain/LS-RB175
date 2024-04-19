### 10th July 2023

- To discuss:
  - Apparently, 'I want to be a dev' is too vague. Any pointers for seeing what kind of job i could/should be aiming for?
  - The Rack/Puma bug.

### 12th September 2023

-  Maybe walk through some of the 175 course together.
- 'In-order delivery' seems like a waste of time, no? That's what the SYN flag is for?
- Talk about part-time work.
- Go through LS170 PDU model to iron out vagueness. ELI5
- discuss: 'The ethernet protocol allows for communication between two devices on a network. The internet protocol allows for communication between two devices anywhere in the world.'
- Difference between the web and the internet.
- Who owns/profits from DNS servers?

### 17th September

- I seem to have forgotten about GemSpec files. Are they really necessary? [eg](https://github.com/SandyRodger/RB130-139/blob/main/lesson_3_packaging_code_into_a_project.md) . Is this for actually writing a Gem? https://launchschool.com/lessons/2fdb1ef0/assignments/918536a2
- 

### 21st September

- Error message, content length should be 60 instead of 61? [here](https://launchschool.medium.com/growing-your-own-web-framework-with-rack-part-4-a4a4da2967a2)
- ERB and Rack in your daily workflow.
- ERB is just the same as String interpolation. [no?](https://launchschool.com/lessons/c3578b91/assignments/d6969b5b0)
- Also, these exercises work on Chrome, but not Safari. Is that a problem?
- Rack v Rake.

### Fri 13th October 4pm

- Is a session like a binding? It captures all the things available in that enviroment at that moment?
- Is Sinatra::Contentfor basically a reverse session? Ie saving a kind of binding information in a template that can be delivered in another template? Is it just for erb templates? OK, I answered my own question. [here's the documentation](https://sinatrarb.com/contrib/content_for)
- methods that take blocks are like cows with 2 stomachs. THe block and the method code do the same thing, but they work better when seperated?

```todo.rb
  def sort_lists(lists, &block)
    complete_lists, incomplete_lists = lists.partition { |list| list_complete?(list)}

    incomplete_lists.each { |list| yield list, lists.index(list) }
    complete_lists.each { |list| yield list, lists.index(list) }
  end
```
- how to change-all within a code block by using v-line?
- When you went through the todo and CMS projects, how purist were you about muddling up a solution before peaking at the solution?
- 
### next chat:

# test/cms_test.rb

- What is last response doing here?

```ruby
  def test_deleting_document
    create_document("test.txt")

    post "/test.txt/delete"

    assert_equal 302, last_response.status

    get last_response["Location"]
    assert_includes last_response.body, "test.txt has been deleted"

    get "/"
    refute_includes last_response.body, "test.txt"
  end
```
