const RiobitToken = artifacts.require("./RiobitToken");
const RiobitTokenSale = artifacts.require("./RiobitTokenSale");
const RiobitTokenWhitelist = artifacts.require("./RiobitTokenWhitelist");

module.exports = function (deployer) {
    deployer.deploy(RiobitToken).then(function () {
        deployer.deploy(RiobitTokenWhitelist).then(function() {
            deployer.deploy(RiobitTokenSale, RiobitToken.address, RiobitTokenWhitelist.address);
        });
    });
};
