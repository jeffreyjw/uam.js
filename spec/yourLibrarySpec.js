describe("assetManager", function() {

    var config = {
        assetTypes: {
            "dummy": function(url, asset){
                asset.data = url + '1';
                asset.done();
            }
        },
        assets: {
            "dummy": [
                "one", "two"
            ]
        }
    };

    var am = new UAM.AssetManager(config);

    it('should load the first asset properly', function(){
        am.onload = function(){
            expect(am.get('one')).toBe('one1');
        };
    });
  
});