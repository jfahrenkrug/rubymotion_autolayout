# RubyMotion Autolayout DSL Demo

This is a very simple RubyMotion app that implements a very basic and generic DSL to create iOS views.

This code...

    createViews(%{[label("Welcome")]
                  [label("Click on a button!")]
                  [image_view("rubymotion")][image_view("rubymotion")][image_view("rubymotion")]
                  [button("Say Hi", hi)][button("Say Bye", bye)]})    

… creates this view:

![RubyMotion Autolayout Screenshot](https://github.com/jfahrenkrug/rubymotion_autolayout/raw/master/screenshot.png)

## How does it work?

`createViews` is a generic layout method that takes a string like shown above to build a simple UI. 

At the moment it simply distributes the available screen real estate evenly to all elements.

It turns "button" into "UIButton", "label" into "UILabel" and "image_view" into "UIImageView"

The first arg in parentheses is the title or the name of a bundled image, the second arg is an action (in case of buttons).

That's it. It's very basic, but I might enhance it in the future.