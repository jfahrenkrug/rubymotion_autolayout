# in 2012 by Johannes Fahrenkrug, http://springenwerk.com

class LayoutViewController < UIViewController
  def viewDidLoad    
    createViews(%{[label("Welcome")]
                  [label("Click on a button!")]
                  [image_view("rubymotion")][image_view("rubymotion")][image_view("rubymotion")]
                  [button("Say Hi", hi)][button("Say Bye", bye)]})    
  end
  
  def hi
    # kinda hackishly accessing the label (2nd entry in the @views array)
    @views[1].text = "Hi!"
  end
  
  def bye
    # kinda hackishly accessing the label (2nd entry in the @views array)
    @views[1].text = "Bye!"
  end
  
  # This is the generic layout method
  # it takes a string like this:
  #
  #   [label("Welcome")]
  #   [label("Click on a button!")]
  #   [image_view("rubymotion")]
  #   [button("Say Hi", hi)][button("Say Bye", bye)]
  #
  # and uses it to build a simple UI. 
  # At the moment it simple distributes the available screen real estate evenly 
  # to all elements.
  # It turns "button" into "UIButton", "label" into "UILabel" and "image_view" into "UIImageView"
  # The first arg in parentheses is the title or the name of a bundled image, the second arg is an action (in case of buttons).
  def createViews(viewString)
    @views = []
    # get the lines
    lines = viewString.split("\n")
    
    # holds the y-offset
    top_offset = 0
    # calculate the height for each element by evenly distributing the space
    element_height = view.frame.size.height / lines.length
    
    lines.each do |line|
      # divide the line into its elements
      elements = line.split('][') 
      # holds the x-offset for this row
      left_offset = 0
      # calculate the width for each element is this row by evenly distributing the space
      element_width = view.frame.size.width / elements.length
      elements.each do |element|
        # get the elemnt string, for example button("Say Hi", hi)
        el = /\[?([^\]^\[]*)\]?/.match(element.strip)[1]
        # get the name, for example button
        element_name = (/^(\w*)/.match(el) || [])[1]
        # get the title, for example "Say Hi"
        element_title = (/\(\s*\"(.*)\"/.match(el) || [])[1]
        # get the action, for example "hi"
        element_action = (/\,\s*(\w*)/.match(el) || [])[1]
        
        #puts "n: #{element_name}, t: #{element_title}, a: #{element_action}"
        
        # hold the view we are about to create
        the_view = nil
        # the frame for the new view
        the_frame = [[left_offset, top_offset], [element_width, element_height]]
        
        # buttons have to be initialized in a special way
        if (element_name == 'button')
          the_view = UIButton.buttonWithType(UIButtonTypeRoundedRect)
          the_view.setTitle(element_title, forState:UIControlStateNormal)
          the_view.addTarget(self, action:element_action, forControlEvents:UIControlEventTouchUpInside) if element_action
          the_view.frame = the_frame
        else
          # for all other cases, get the Cocoa class...
          cocoa_class = NSClassFromString("UI#{element_name.split('_').map(&:capitalize).join}")
          # ... and create an instance of it
          the_view = cocoa_class.alloc.initWithFrame(the_frame)
        end
        
        if the_view.respond_to?('setText') and element_title
          # if possible, set the text
          the_view.setText(element_title) 
        elsif the_view.respond_to?('setImage') and element_title
          # if possible, set the image
          the_view.setImage(UIImage.imageNamed(element_title))
        end
        
        # if possible, set the content mode
        the_view.setContentMode(UIViewContentModeScaleAspectFit) if the_view.respond_to?('setContentMode')
        
        # add the view to our array
        @views << the_view
        
        # and to the superview
        self.view.addSubview(the_view)
        
        left_offset += element_width
      end
      
      top_offset += element_height
    end
  end
  


end