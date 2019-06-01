const request = require("request");

module.exports.format = [
];

module.exports.auth_required = true;

module.exports.privs = ["USER_LIFE"];


module.exports.callback = function (proxy) {
    request.post({
        method: "POST",
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        },
        url: `${proxy.cfg.network.manager_use_ssl ? "https://" : "http://" }${proxy.cfg.managerIP}:${proxy.cfg.managerPort}/api/logout_all`,
        body: JSON.stringify(proxy.recv)
    }, (err, resp, body) => {
        proxy.send(body)
    })
};
