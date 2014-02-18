"use strict"

class UAM.AssetManager

  config: null
  assetTypes: null
  assetsToLoad: null
  loadedAssets: null
  assetsToLoadLength: 0
  loadedAssetsLength: 0
  listeners: null

  #
  # The config object is of following format:
  # {
  #   assetTypes: {
  #     "assetType": function(url, asset)
  #   }
  #   assets: {
  #     "assetType": [ assetUrl1, assetUrl2, ... ]
  #   }
  # }
  #
  constructor: (config) ->
    this.config = config
    this.assetTypes = config.assetTypes
    this.assetsToLoad = config.assets
    this.loadedAssets = {}

    this.listeners = {
      "error": [],
      "loaded": [],
      "progress": []
    }


  addEventListener: (event, callback) ->
    this.listeners[event].push(callback)


  _callEventListeners: (event, asset) ->
    for listener in this.listeners[event]
      if event != "error"
        listener(this.loadedAssetsLength, this.assetsToLoadLength)
      else
        listener(asset.url)


  load: () ->
    this.assetsToLoadLength = 0

    for key of this.assetsToLoad
      for url in this.assetsToLoad[key]
        ++this.assetsToLoadLength

    if this.assetsToLoadLength == 0
      this._callEventListeners("loaded", null)
      return

    for key of this.assetsToLoad
      for url in this.assetsToLoad[key]
        this.loadAsset(key, url)


  loadAsset: (assetType, url) ->
    if url not of this.loadedAssets
      asset = new UAM.Asset(url, this)
      this.assetTypes[assetType](url, asset)


  get: (url) ->
    data = null
    if url of this.loadedAssets
      data = this.loadedAssets[url].data

    return data


  _assetLoaded: (asset) ->
    this.loadedAssets[asset.url] = asset
    ++this.loadedAssetsLength;

    this._callEventListeners("progress", asset)

    if this.loadedAssetsLength == this.assetsToLoadLength
      this._callEventListeners("loaded", asset)


  _raiseError: (asset) ->
    this._callEventListeners("error", asset)
