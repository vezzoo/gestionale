import {POST} from './network'
import React from "react";
import {apiCalls} from "./consts";

function auth(continueLIN, user, psw, show) {
    POST(apiCalls.auth, {user: user, psw: psw}).then(res => {
        console.log(res)
        if (!res || !res.state) {
            show("ERRORE", `Login failed: ${res.err}`, true);
            return;
        }

        if (!res.secure) {
            show("ATTENZIONE", "Credenziali non sicure!!!", true);
        }

        window.ctx.set("isLogged", true);
        window.ctx.set("username", res.username);
        window.ctx.set("name", res.name);
        window.ctx.set("token", res.token);
        window.ctx.set("admin", res.isAdmin);

        document.cookie = JSON.stringify({
            wasLogged: true,
            username: res.username,
            name: res.name,
            token: res.token,
            isAdmin: res.isAdmin
        });

        if (res.secure) {
            continueLIN();
        }
    })
}

export {auth};
