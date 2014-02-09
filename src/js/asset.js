"use strict";
UAM.Asset = (function() {
  Asset.prototype.assetManager = null;

  Asset.prototype.data = null;

  Asset.prototype.url = null;

  function Asset(url, assetManager) {
    this.assetManager = assetManager;
    this.url = url;
  }

  Asset.prototype.done = function() {
    return this.assetManager._assetLoaded(this);
  };

  Asset.prototype.error = function() {
    return this.assetManager._raiseError(this);
  };

  return Asset;

})();
