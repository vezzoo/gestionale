module.exports.auth_required = true;
module.exports.privs = ["STORICO"];

module.exports.format = [{
    field: "ordid",
    required: true,
    type: "string",
    strict: false
}];

module.exports.callback = (proxy) => {
    proxy.getConnection().query(`DELETE FROM ordini_dettagli where id_distict = '${proxy.secure(proxy.recv.ordid)}'`, (e) => {
        console.log(e);
        proxy.send({state: "OK"});
    });
};