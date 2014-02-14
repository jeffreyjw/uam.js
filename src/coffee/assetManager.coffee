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

    if (this.onload != null)
      this.onload(this.loadedAssetsLength, this.assetsToLoadLength)

  _raiseError: (asset) ->
    if this.onerror != null
      this.onerror(asset.url)
