module.exports.auth_required = true;
module.exports.privs = ["STORICO"];

module.exports.format = [];

module.exports.callback = (proxy) => {
    proxy.getConnection().query(`DELETE FROM ordini_dettagli`, (e) => {
        console.log(e);

        proxy.getConnection().query(`INSERT INTO ordini_dettagli(id_distict, ordnum, message, asporto, client, timestamp, user) VALUES ('----', '0000', '', 0, '--', 0, 'reprint')`, (e) => {
            console.log(e);

            if (e)
                proxy.send({state: "Errore"});
            else
                proxy.send({state: "OK"});
        });
    });
};