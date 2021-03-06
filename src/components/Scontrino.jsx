import * as jsPDF from "jspdf"
import * as Base64 from "base-64"
import React from "react";
import qrc from 'qrious'
import Typography from "@material-ui/core/es/Typography/Typography";
import {GET, GETSync, POST} from "../network";
import {apiCalls, orderCifres} from "../consts";
import Snackbar from "@material-ui/core/es/Snackbar/Snackbar";
import CircularProgress from "@material-ui/core/es/CircularProgress/CircularProgress";
import Grid from "@material-ui/core/es/Grid/Grid";
import * as cfg from "../configs/network.config"

Number.prototype.pad = function (size) {
    let s = String(this);
    while (s.length < (size || 2)) {
        s = "0" + s;
    }
    return s;
};

let write = (doc, font, variant, size, x, y, text) => {
    doc.setFont(font);
    doc.setFontSize(size);
    doc.setFontType(variant);
    doc.text(x, y, text);
};

class Scontrino extends React.Component {

    _data = <Grid container spacing={0} alignItems="center" justify="center"><Grid item xs={12}><Typography variant="title">Caricamento...</Typography></Grid><Grid item xs={12}><CircularProgress disableShrink/></Grid></Grid>;

    map = new Map();
    kw = null;
    calling = true;

    _createMap(kw) {
        this.kw = kw;
        Object.keys(kw).forEach(e => this.map.set(kw[e], this.props.kw[e] ? this.props.kw[e] : ""))
    }

    _elem(element, e, offset = 0) {
        Object.keys(e).forEach(q => {
            this.map.set(this.kw[q], e[q]);
        });
        this._parse(JSON.parse(JSON.stringify(element)), offset)
    }

    _parse(element, offset = 0) {
        try {
            for (let i = 0; i < element.length; i++) {
                let e = element[i];
                switch (e.type) {
                    case "reference":
                        if (e.path === "null") break;
                        let obj = JSON.parse(GETSync(e.path));
                        obj.x += e.x;
                        obj.y += e.y;
                        element.push(obj);
                        break;
                    case "image":
                        this.doc.addImage(e.data, e.format, e.x, e.y + offset, e.w, e.h);
                        break;
                    case "text":
                        if (e.parse) this.map.forEach((v, k) => e.text = e.text.replace(k, v));
                        write(this.doc, e.font, e.variant, e.size, e.x, e.y + offset, JSON.parse(JSON.stringify(e.text)));
                        break;
                    case "qr":
                        if (e.parse) this.map.forEach((v, k) => e.data = e.data.replace(k, v));
                        let elm = document.createElement("canvas");
                        // noinspection JSPotentiallyInvalidConstructorUsage
                        let qr = new qrc({
                            element: elm,
                            value: e.data,
                            background: e.bg,
                            foreground: e.fg,
                            level: e.correction,
                            size: e.size
                        });
                        this.doc.addImage(elm.toDataURL(), "PNG", e.x, e.y + offset, Math.floor(e.size / 3.77), Math.floor(e.size / 3.77));
                        break;
                    case "line":
                        this.doc.setLineWidth(e.width);
                        this.doc.line(e.coordsx[0], e.coordsy[0] + offset, e.coordsx[1] + offset, e.coordsy[1] + offset);
                        break;
                    case "rect":
                        this.doc.setDrawColor(e.border[0], e.border[1], e.border[2]);
                        this.doc.setFillColor(e.fill[0], e.fill[1], e.fill[2]);
                        this.doc.roundedRect(e.x, e.y + offset, e.w, e.h, e.round, e.round, e.dofill ? 'FD' : 'D');
                        break;
                    default:
                        console.error(`INEXISTENT ELEMENT ${e.type}`);
                }
            }
        } catch (e) {
            this._data = <Snackbar
                anchorOrigin={{
                    vertical: 'bottom',
                    horizontal: 'left',
                }}
                open={true}
                autoHideDuration={6000}
                ContentProps={{
                    'aria-describedby': 'message-id',
                }}
                message={<span id="message-id">{e}</span>}
                action={[]}
            />
        }
    }

    _page(page, elem) {
        this._parse(JSON.parse(JSON.stringify(page.header.content)), 0);

        let completed = false;
        if (elem !== undefined)
            elem.forEach((e, i) => {
                if(this.props.fixedHeight && page.header.height + i * page.element.height + page.footer.height > this.props.fixedHeight){
                    this._parse(page.footer.content, this.props.fixedHeight - page.footer.height);
                    this.doc.addPage();
                    this._page(page, elem.slice(i, elem.length));
                    completed = true;
                } else this._elem(page.element.content, e, page.header.height + i * page.element.height);
            });

        if(!completed) this._parse(page.footer.content, page.header.height + page.element.height * elem.length);
    }

    _generate(res) {
        let fullArr = [];
        console.log(this.props.elementi);
        Object.keys(this.props.elementi).forEach(e => {
            fullArr.push(...this.props.elementi[e])
        });

        let unique = [];
        fullArr.forEach(e => {
            if (!unique.includes(JSON.stringify(e))) unique.push(JSON.stringify(e));
        });

        fullArr = unique.map(e => JSON.parse(e));

        let height = res.main.header.height + res.main.element.height * fullArr.length + res.main.footer.height;
        if(this.props.fixedHeight && height < this.props.fixedHeigh) height = this.props.fixedHeigh;
        // noinspection JSPotentiallyInvalidConstructorUsage
        this.doc = new jsPDF({
            orientation: height > res.width ? 'portait' : 'landscape',
            unit: 'mm',
            format: [res.width, height]
        });
        this._createMap(res.kw);
        this._page(res.main, fullArr);

        Object.keys(this.props.elementi).forEach(e => {
            if(cfg.toPrinter.includes(e)) return;
            if(e === "NO_CATEGORY") return;
            this.map.set(this.kw["category"], `${e}`);
            if (this.props.elementi[e].length > 0) {
                let height = res.details.header.height + res.details.element.height * this.props.elementi[e].length  + res.details.footer.height;
                this.doc.addPage([res.width, height], height > res.width ? 'portait' : 'landscape');
                this._page(res.details, this.props.elementi[e])
            }
        });

        this._data = <embed id="tobeprinted" width="100%" height="99%"
                            src={"data:application/pdf;base64," + Base64.encode(this.doc.output())}
                            type="application/pdf" internalinstanceid="12"/>;
        this.props.onScontrinoLoaded();
        this.forceUpdate();
    }

    createPaper() {
        if (this.props.path)
            GET(this.props.path).then(res => {
                this._generate(res)
            });
        else this._generate(JSON.parse(JSON.stringify(this.props.object)))
    }

    componentDidMount() {
        if (this.props.kw.ordnum === null)
            POST(apiCalls.getOrdNum, {
                user: window.ctx.get("username"),
                token: window.ctx.get("token")
            }).then(res => {
                this.props.kw.ordnum = res.ordnum.pad(orderCifres);
                this.props.kw.date = Date.now();
                this.createPaper();
            });
        else {
            this.props.kw.date = Date.now();
            this.createPaper();
        }
    }

    componentDidUpdate(prevProps, prevState, snapshot) {
        if (this.calling) {
            this.createPaper();
            this.calling = false
        } else this.calling = true
    }

    render() {
        return this._data;
    }
}

export default Scontrino

