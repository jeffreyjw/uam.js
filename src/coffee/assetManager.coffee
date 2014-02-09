"use strict"

class UAM.AssetManager

  config: null
  assetTypes: null
  assetsToLoad: null
  loadedAssets: null
  onload: null
  onerror: null
  assetsToLoadLength: 0

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

  load: () ->
    this.assetsToLoadLength = 0

    for key of this.assetsToLoad
      for url in this.assetsToLoad[key]
        ++this.assetsToLoadLength

    for key of this.assetsToLoad
      for url in this.assetsToLoad[key]
        this.loadAsset(key, url)

  loadAsset: (assetType, url) ->
    if url not in this.loadedAssets
      this.assetTypes[assetType](url, this)

  getAsset: (url) ->
    return

  _assetLoaded: (asset) ->
    this.loadedAssets[asset.url] = asset

    if (this.loadedAssets.length == this.assetsToLoadLength) and (this.onload != null)
      this.onload()

  _raiseError: (asset) ->
    return
