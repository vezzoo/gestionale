import {apiCalls, connection_status} from "./consts";

const GET = async (path) => {
    const response = await fetch(path);
    const body = await response.json();

    if (response.status !== 200) throw Error(body.message);

    return body;
};

const GETSync = (path) => {
    let xmlHttp = new XMLHttpRequest();
    xmlHttp.open("GET", path, false);
    xmlHttp.send(null);
    return xmlHttp.responseText;
};

const getOperationMode = () => {
    try {
        let hello = this.GETSync(apiCalls.hello);
        return connection_status[JSON.parse(hello).kind];
    } catch (e) {
        console.log(e);
        return connection_status.noapi;
    }
};

let POST = async (path, form) => {
    const response = await fetch(path, {
        method: "POST",
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(form)
    });
    let body;
    try {
        body = await response.json();
    } catch (e) {
        throw Error(`JSON ERROR requiring ${path}: ${JSON.stringify(response.body, true)}`)
    }

    if (response.status !== 200) throw Error(body.message);

    return body;
};

let POSTSync = (path, form) => {
    let xmlHttp = new XMLHttpRequest();
    xmlHttp.open("POST", path, false);
    xmlHttp.setRequestHeader('Content-type', 'application/json');
    xmlHttp.send(JSON.stringify(form));
    return xmlHttp.responseText;
};

export {GET, GETSync, POST, POSTSync}