function getNowPlayingMoviesData(str as string)
    result = []
    data = ParseJSON(str).results
    for each movie In data
      item = {}
      item.title = movie.title
      item.description = movie.overview
      item.id = movie.id
      if isValid(movie.backdrop_path) then item.hdposterurl = "https://image.tmdb.org/t/p/w780" + movie.backdrop_path
      if isValid(movie.backdrop_path) then item.herobannerurl = "https://image.tmdb.org/t/p/original" + movie.backdrop_path
      result.push(item)
    end for
    return result
end function

function getPopularMoviesData(str as string)
  result = []
  data = ParseJSON(str).results
  for each movie In data
    item = {}
    item.title = movie.title
    item.description = movie.overview
    item.id = movie.id
    if isValid(movie.poster_path) then item.hdposterurl = "https://image.tmdb.org/t/p/w780" + movie.poster_path
    if isValid(movie.backdrop_path) then item.herobannerurl = "https://image.tmdb.org/t/p/original" + movie.backdrop_path
    result.push(item)
  end for
  return result
end function

function createContentNode(list as object)
  item = createObject("RoSGNode", "ContentNode")
  AddAndSetFields(item, list)
  return item
end function

function createRow(list as object, title as string)
  Parent = createObject("RoSGNode", "ContentNode")
  row = createObject("RoSGNode", "ContentNode")
  row.Title = title
  for each itemAA in list
    item = createObject("RoSGNode", "ContentNode")
    AddAndSetFields(item, itemAA)
    row.appendChild(item)
  end for
  Parent.appendChild(row)
  return Parent
end function

function createGrid(list as object)
  Parent = createObject("RoSGNode", "ContentNode")
  for i = 0 to list.count() - 1 step 4
    row = createObject("RoSGNode", "ContentNode")
    for j = i to i + 3
      if list[j] <> invalid
        item = createObject("RoSGNode", "ContentNode")
        AddAndSetFields(item, list[j])
        row.appendChild(item)
      end if
    end for
    Parent.appendChild(row)
  end for
  return Parent
end function

function AddAndSetFields(node as object, aa as object)
  addFields = {}
  setFields = {}
  for each field in aa
    if node.hasField(field)
      setFields[field] = aa[field]
    else
      addFields[field] = aa[field]
    end if
  end for
  node.setFields(setFields)
  node.addFields(addFields)
end function

function isValid(params)
  return params <> invalid
end function