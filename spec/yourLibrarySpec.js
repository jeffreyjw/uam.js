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
        var flag = false;
        var data = null;

        runs(function(){
            am.onload = function(){
                data = am.get('one');
                flag = true;
            };

            am.load();
        });

        waitsFor(function(){
            return flag;
        }, 'The value should be equal', 500);

        runs(function(){
            expect(data).toBe('one1');
        });
    });
  
});