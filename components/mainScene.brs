sub init()
    m.top.setFocus(true)
    m.LandingScreen = m.top.FindNode("LandingScreen")
    m.LandingScreen.visible = true
    m.LandingScreen.setFocus(true)
end sub

sub OnAppLaunchCompleted()
    m.top.signalBeacon("AppLaunchComplete")
end sub