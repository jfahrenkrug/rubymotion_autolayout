# in 2012 by Johannes Fahrenkrug, http://springenwerk.com

class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    
    @window.rootViewController = layout_view_controller
    @window.rootViewController.wantsFullScreenLayout = true
    @window.makeKeyAndVisible
    return true
  end
  
  def layout_view_controller
    @layout_view_controller ||= LayoutViewController.alloc.init
  end
end
