"use strict"

class UAM.Asset
  assetManager: null
  data: null
  url: null

  constructor: (url, assetManager) ->
    this.assetManager = assetManager
    this.url = url

  done: () ->
    this.assetManager._assetLoaded(this)

  error: () ->
    this.assetManager._raiseError(this)