sub Main(input as dynamic)
  if input <> invalid
    if input.contentID <> invalid and input.mediaType <> invalid
      m.contentID = input.contentID
      m.mediaId = input.mediaType
      showMainScreen(m.contentID, m.mediaId)
    else
      showMainScreen()
    end if
  else
    showMainScreen()
  end if
end sub

sub showMainScreen(contentID = "", mediaType = "")
  screen = CreateObject("roSGScreen")
  m.port = CreateObject("roMessagePort")

  m.global = screen.getGlobalNode()
  m.global.addFields({
    lastScreen: "",
    access_token: "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhMTgyODUwMjQ1ZDc2YTAxNmU1MTU4MzkzMGUwZDA0NSIsInN1YiI6IjYzYmRhODA4NWJlMDBlMDBlN2EyNGQwYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.RbKgzbgBL32vD_u_8eMZWulJoceVxtKbTT0S7b7f3UM", 
    deeplink_content: contentID,
    deeplink_media: mediaType,
    })
  m.global.id = "GlobalNode"

  scene = screen.CreateScene("MainScene")
  screen.setMessagePort(m.port)
  screen.show()

  while(true)
    msg = wait(0, m.port)
    msgType = type(msg)
    if msgType = "roSGScreenEvent"
      if msg.isScreenClosed() then return
    end if

    if msgType = "roInputEvent"
      if msg.IsInput()
        info = msg.GetInfo()
        ' print "INFO: " + msg.getInfo()
        ' if info.DoesExist("mediatype") and info.DoesExist("contentid")
        '   print info.contentid" "info.mediatype
        ' end if
      end if
    end if
  end while
end sub