UAM.js
===

UAM.js is a Universal Asset Manager, designed to be easy extendable for many asset types

### Maintainer

[jeffreyjw](https://github.com/jeffreyjw)

### Get Started

Download and include the library in your application:

`<script src="uam.min.js"></script>`

Run Tests

Open `SpecRunner.html` in your browser and test with jasmine

### How to use

First you need to create a configuration object. The object has two keys:
in assetTypes you declare what needs to be done when the manager will load an asset,
and assets key is an object containing pointers to assets (most commonly those will
be URL strings, but can be anything, like arrays).

Here's an example of loading images:

```javascript
var config = {
    assetTypes: {
        "image": function(url, asset){
            var img = new Image();
            img.onload = function(){
                asset.data = img;
                asset.done();
            };
            img.onerror = function(){ asset.error(); };

            img.src = url;
        }
    },
    assets: {
        "image": [
            "images/image1.png",
            "images/image2.png"
        ]
    }
};
```

After that, we just load everything with an AssetManager:

```javascript
var assetManager = new UAM.AssetManager(config);
assetManager.onload = function(){
    // use the loaded images
    var myImage = assetManager.get('images/image1.png');
};
assetManager.load();
```

### License

The MIT License (MIT)

Copyright (c) 2013 jeffreyjw

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
