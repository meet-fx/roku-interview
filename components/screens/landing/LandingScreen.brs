sub Init()
  'observer for screen visibility
  m.top.observeField("visible", "onVisibleChange")
  'rails or carousels of movies
  m.rowList = m.top.findNode("RowList")
  'background poster of hero part
  m.heroBanner = m.top.findNode("heroBanner")
  'loading to let know user the channel is retrieving the content
  m.loadingText = m.top.findNode("loading")
  'repositioning of loading text to center of the screen
  m.loadingText.translation = [(1920 - m.loadingText.boundingRect().width) / 2, (1080 - m.loadingText.boundingRect().height) / 2]
  'content node for video player
  m.videoContent = createObject("RoSGNode", "ContentNode")
  'fetching first rail or carousel
  fetchNowPlayingMovies()
end sub

sub onVisibleChange()
  if m.top.visible
    m.rowList.setFocus(true)
  end if
end sub

sub showLoading()
  m.loadingText.visible = true
end sub

sub hideLOading()
  m.loadingText.visible = false
end sub

sub fetchNowPlayingMovies()
  'shows loading texr
  showLoading()
  'separate task for API request
  requestTask = CreateObject("roSGNode", "RequestTask")
  requestTask.status = "None"
  requestTask.type = "get"
  requestTask.url = "https://api.themoviedb.org/3/movie/now_playing"
  requestTask.observeField("status", "onNowPlayingFetched")
  requestTask.control = "RUN"
end sub

function onNowPlayingFetched(event as object)

end function

sub fetchPopularMovies()
  'https://api.themoviedb.org/3/movie/popular
end sub

function onPopularFetched(event as object)

end function

sub onItemFocused()

end sub

sub updateHeroContent()

end sub