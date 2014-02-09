"use strict"

class UAM.AssetManager

  config: null
  assetTypes: null
  assetsToLoad: null
  loadedAssets: null
  onload: null
  onerror: null
  assetsToLoadLength: 0
  loadedAssetsLength: 0

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
      asset = new UAM.Asset(url, this)
      this.assetTypes[assetType](url, asset)

  get: (url) ->
    return this.loadedAssets[url].data

  _assetLoaded: (asset) ->
    this.loadedAssets[asset.url] = asset
    ++this.loadedAssetsLength;

    if (this.loadedAssetsLength == this.assetsToLoadLength) and (this.onload != null)
      this.onload()

  _raiseError: (asset) ->
    return
