# [Adding JavaScript](https://launchschool.com/lessons/2c69904e/assignments)

## [Introduction](https://launchschool.com/lessons/2c69904e/assignments/c6a612e5)

- Modern web-applications can do a lot of the work on the server before sending HTML / CSS / Javascript.
- Nevertheless there are times when running code directly within the page in the web-browser is the better move.
- Javascript can do things HTML can't do by itself. For instance:
  - creating drag/drop user-interfaces
  - submitting forms using methods other than `GET` and `POST`.
  - Perform actions without having to reload the page. (like facebook likes?)

## [A JavaScript Primer](https://launchschool.com/lessons/2c69904e/assignments/2d13e2f2)

- This lesson is about writing JavaScript code which executes in the user's browser IN ADDITION TO Ruby code running on the server.
- We'll be using the Jquery library in the client-side code.
- Watch [these three youtube videos](https://www.youtube.com/watch?v=hMxGhHNOkCU&index=1&list=PLoYCgNOIyGABdI2V8I_SWo22tFpgh2s6)
- You needn't learn javascript to proficiency, just get the gist at this point.
- The goal of this lesson is to show you how to build functionality that relies on both client and server-side code.
- There's no JS assessment until after JS210.

## [JQuery videos](https://www.youtube.com/watch?v=hMxGhHNOkCU&index=1&list=PLoYCgNOIyGABdI2V8I_SWo22tFpgh2s6)

### Video 1 - jQuery Methods

- Every employer uses jQuery, so if you're training to be a software engineer, then learn this ater HTML/CSS.
- It's the easiest and most popular JS library.

1. Download it from jQuery.com, then put it in your project folder.
2. Add a script tag with the source:

```html
<script src="bower_components/jquery/jquery.js"></script>
```
This step makes the library of commands available, but doesn't call any of them. So memorise the following and do your JavaScript inside the document-ready-function:

```html
<script>
  $(document).ready(function() {

});
</script>
```

- `$` always references the JS object.
- The document-ready-function says 'wait for my whole document to laod, before running any JS.
- `$(function()` is a shorter way of writing `(document).ready(function()`.

3. [03:00] There's two parts to each function - the selector and the method:
    - `$("panel1").hide();`
  -  and you can chain as many methods as you want:
    -  `$("panel1").hide(300).show(1000).hide(300).show(1000);`
  - Other methods include:
    - `.slideUp()`
    - `.slideDown()`
    - `.slideToggle()`
    - `.delay()`
    - `.fadeIn()`
    - `.fadeOut()`
    - `.fadeToggle()`
    - `.toggle()`
  - [5:10] `.css` for styling your javascript (with curly braces):
    - ("#panel1").css({color:'red'});
    - ("#panel1").css({color:'red', fontWeight: 'bold'}); OR
    - ("#panel1").css({color:'red', 'font-weight': 'bold'});
  - [06:20] Any time you have curly braces in JS you're making a JS object.

### Video 2 - Listening to Events

- [00:20] HTML methods. For re-writing the HTML of a section:
  - `$('#btn1').html('my button <strong>my bold </strong>');`
  - Too much of this is considered bad practice, so should be avoided.
- [01:30] Events.
  - `$('#btn1').on('click', function() {})`
- [03:00]
```html
  $('panel1'.on('click', function() {
    $(#panel1').slideToggle(200);
  });
```
- [04:00] multiple buttons that appear and disappear when you click on them.
  - `mouseover` method.
- [05:20] `find` and `html` method, for changing panel content.

### Video 3 - Writing smarter, better code

- DRYing this:

```html
  $('btn1'.on('click', function() {
    $(#panel1').toggle();
  });
```
- [00:40] Targeting by attribute
  - `$('button[id=btn1')`
  - Change html buttons to add attributes:
    - `<button id="btn1" data-panelid="panel1">#btn1</button>`
  - Get rid of ids and replace them with classes, because you can only have one id, but you can share the same class among many objects:
    - `<button class="panel-button" data-panelid="panel1">#btn1</button>`
  - and then in your JS:

```html
  $('.panel-button').on(.click , function() {
    $('panel1').toggle();
  });
```
 - At this point when you click on any of the buttons it will toggle panel 1.
 - [02:57] Get panel ID

```html
  $('.panel-button').on(.click , function() {
    var panelId = $(this).attr('data-panelId');
    alert(panelId)    # this just prompts an alert, to test we have the right element.
  });
```

```html
  $('.panel-button').on(.click , function() {
    var panelId = $(this).attr('data-panelId');
    $('#'+panelId).toggle();
  });
```

- This method now takes whatever you click on and toggles the appropriate panel.
- [05:00]

## [Including JavaScript Files](https://launchschool.com/lessons/2c69904e/assignments/b5a661d9)

- Downloading and setting up [jQuery](https://jquery.com/)
- Version 2 is not available?
- compressed v. uncompressed assets.
- Creating a `javascripts` directory within `public`.
- `wget`
- Add a reference to jQuery in `layout.erb`.
- script tags are unnecessary.

```layout.erb
<script src="/javascripts/jquery-3.7.1.slim.js"></script>
<script src="/javascripts/application.js"></script>
```

```application.js
console.log("this is a test")
```

- Checking all of this in the inspector.

## [Confirming Destructive Actions](https://launchschool.com/lessons/2c69904e/assignments/7d9fd7b7)

- `confirm` method

## [Making HTTP Requests From JavaScript](https://launchschool.com/lessons/2c69904e/assignments/94ee8ca2)

- I'm getting a bug here. This is a little too much for me right now, so I'll circle back to it.

## [Adding Identifiers to Todo Items](https://launchschool.com/lessons/2c69904e/assignments/af479b47)

- The last step created a bug.
-  Indexing error.
- My brain is not present.

## [Adding Identifiers to Lists](https://launchschool.com/lessons/2c69904e/assignments/a8c93890)

- I'm too depressed to think.

## [Quiz](https://launchschool.com/lessons/2c69904e/assignments/4e784353)

| Question | My answer | correct? | Correction |
| :--- | :---: | :---: | :---: |
|1.||yes||
|2.| |yes||
|3.| |yes||
|4.| |yes||
|5.| A, B, C, D| not B| Unique identifiers are not necessarily sequential. Even if you do use sequential values when creating identifiers, deleting items from the data will result in gaps in the sequence.|
|6.| A, B, D| B, C, D| A. Index numbers change when items in the list change position, which can happen with deletions, rearranging and sorting items, and inserting new items into the list. C. Deleting an item from a list can result in an immediate change in index numbers.
|total|4/6 (67%)|

