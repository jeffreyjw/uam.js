"use strict";
UAM.AssetManager = (function() {
  AssetManager.prototype.config = null;

  AssetManager.prototype.assetTypes = null;

  AssetManager.prototype.assetsToLoad = null;

  AssetManager.prototype.loadedAssets = null;

  AssetManager.prototype.onload = null;

  AssetManager.prototype.onerror = null;

  AssetManager.prototype.assetsToLoadLength = 0;

  AssetManager.prototype.loadedAssetsLength = 0;

  function AssetManager(config) {
    this.config = config;
    this.assetTypes = config.assetTypes;
    this.assetsToLoad = config.assets;
    this.loadedAssets = {};
  }

  AssetManager.prototype.load = function() {
    var key, url, _i, _len, _ref, _results;
    this.assetsToLoadLength = 0;
    for (key in this.assetsToLoad) {
      _ref = this.assetsToLoad[key];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        url = _ref[_i];
        ++this.assetsToLoadLength;
      }
    }
    _results = [];
    for (key in this.assetsToLoad) {
      _results.push((function() {
        var _j, _len1, _ref1, _results1;
        _ref1 = this.assetsToLoad[key];
        _results1 = [];
        for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
          url = _ref1[_j];
          _results1.push(this.loadAsset(key, url));
        }
        return _results1;
      }).call(this));
    }
    return _results;
  };

  AssetManager.prototype.loadAsset = function(assetType, url) {
    var asset;
    if (!(url in this.loadedAssets)) {
      asset = new UAM.Asset(url, this);
      return this.assetTypes[assetType](url, asset);
    }
  };

  AssetManager.prototype.get = function(url) {
    var data;
    data = null;
    if (url in this.loadedAssets) {
      data = this.loadedAssets[url].data;
    }
    return data;
  };

  AssetManager.prototype._assetLoaded = function(asset) {
    this.loadedAssets[asset.url] = asset;
    ++this.loadedAssetsLength;
    if (this.onload !== null) {
      return this.onload(this.loadedAssetsLength, this.assetsToLoadLength);
    }
  };

  AssetManager.prototype._raiseError = function(asset) {
    if (this.onerror !== null) {
      return this.onerror(asset.url);
    }
  };

  return AssetManager;

})();
