import React from 'react'
import {withStyles} from '@material-ui/core/styles';
import NavBar from "./components/NavBar";
import Paper from "@material-ui/core/es/Paper/Paper";
import List from "@material-ui/core/es/List/List";
import Scontrino from "./components/Scontrino";
import Grid from "@material-ui/core/es/Grid/Grid";
import FormControlLabel from "@material-ui/core/es/FormControlLabel/FormControlLabel";
import {POST} from "./network";
import {apiCalls, mqttServer, scontrinoModel} from "./consts";
import Checkbox from "@material-ui/core/es/Checkbox/Checkbox";
import {getBillData, getCarts, renderCart} from "./Cart";
import * as mqtt from "mqtt";
import Button from "@material-ui/core/es/Button/Button";
import IconButton from "@material-ui/core/es/IconButton/IconButton";
import SearchIcon from "@material-ui/icons/Search"
import CloseIcon from "@material-ui/icons/Close"
import SearchProgressIcon from "@material-ui/icons/Settings"
import QrIcon from "@material-ui/icons/Camera"
import DialogTitle from "@material-ui/core/es/DialogTitle/DialogTitle";
import DialogContent from "@material-ui/core/es/DialogContent/DialogContent";
import DialogContentText from "@material-ui/core/es/DialogContentText/DialogContentText";
import TextField from "@material-ui/core/es/TextField/TextField";
import DialogActions from "@material-ui/core/es/DialogActions/DialogActions";
import Dialog from "@material-ui/core/es/Dialog/Dialog";
import QrReader from "react-qr-reader";
import Snackbar from "@material-ui/core/es/Snackbar/Snackbar";
import OrderListItem from "./components/OrderListItem";
import * as cfg from "./configs/network.config";
import DeleteIcon from '@material-ui/icons/Delete';
import Modal from "@material-ui/core/Modal";

const styles = theme => ({
    marginTop: {
        marginTop: 64,
        height: "calc(100vh - 66px)",
        width: "100%",
        overflowY: "auto",
        overflowX: "hidden"
    },
    container: {
        height: "calc(100vh - 66px)",
        width: "100%",
        overflowY: "auto",
        overflowX: "hidden",
        zIndex: -2,
    },
    conttainer: {
        height: "calc(100vh - 66px)",
        width: "100%",
        overflowY: "auto",
        overflowX: "hidden",
        zIndex: -2,
        backgroundColor: "#AAA"
    },
    cvs: {
        width: '100%',
        height: '100%',
        overflowX: 'hidden'
    },
    even: {
        backgroundColor: "#CCC"
    },
    paper: {
        padding: 10
    },
    scr: {
        height: 500
    },
    foo: {},
    appBar: {
        top: 'auto',
        bottom: 0,
    },
    toolbar: {
        alignItems: 'center',
        justifyContent: 'space-between',
    },
    paperr: {
        position: 'absolute',
        width: theme.spacing.unit * 50,
        backgroundColor: theme.palette.background.paper,
        boxShadow: theme.shadows[5],
        padding: theme.spacing.unit * 4,
        outline: 'none',
        top: '20%',
        left: '50%',
        transform: 'translate(-50%, -50%) !important',
    },
    rightItems: {
        float: 'right',
        marginTop: '15px'
    }
});

class Storico extends React.Component {

    state = {
        list: [],
        ord: {},
        snacktextStorico: "",
        openStorico: false,
        openModal: false
    };

    client = null;

    componentDidMount() {
        POST(apiCalls.getStorico, {user: window.ctx.get("username"), token: window.ctx.get("token")}).then(res => {
            if (res.state) {
                this.setState({list: res.list});
                if (Object.keys(this.state.list).length > 0) {
                    // this.setState({ord: this.state.list[Object.keys(this.state.list)[0]], open: true})
                }
            }
        });

        this.client = mqtt.connect(mqttServer);
        this.client.on('connect', () => {
            this.client.subscribe(cfg.mqtt["order-official"], (e) => {
                console.log(e)
            })
        });

        let that = this;
        this.client.on('message', function (topic, message) {
            let obj = JSON.parse(message.toString());
            that.state.list[obj.orderID] = {
                cart: obj.cart,
                time: obj.time,
                ordnum: obj.ordnum,
                message: obj.message,
                asporto: obj.asporto !== 0,
                ip: obj.ip,
                totale: obj.totale,
                orderID: obj.orderID,
                user: obj.user,
            };
            that.forceUpdate()
        })
    }

    componentWillUnmount() {
        this.client.end();
    }

    render() {
        return (
            <div>
                <NavBar elements={[
                    <IconButton color="inherit" onClick={() => this.setState({search: true})}>
                        {this.state.doSearch ? <SearchProgressIcon/> : <SearchIcon/>}
                    </IconButton>,
                    <IconButton color="inherit"
                                onClick={() => this.setState({openModal: true, msgModal: "Sei sicuro di voler eliminare tutti gli ordini presenti nel database? Questa operzione non è\nreversibile!", from: "database"})}><DeleteIcon/></IconButton>

                ]} titleText='Storico ordini' history={this.props.history} showHome={true}/>

                <Paper className={this.props.classes.marginTop}>
                    <Grid container spacing={0}>
                        <Grid item xs={12} lg={3}>
                            <Paper className={this.props.classes.conttainer}>
                                <List>
                                    {Object.keys(this.state.list).reverse().filter(e => {
                                        if (!this.state.doSearch) return true;
                                        if (this.state.id) return e === this.state.id;
                                        if (this.state.num) return this.state.list[e].ordnum === this.state.num;
                                    }).map((e) =>
                                        <OrderListItem id={e} onClick={() => {
                                            this.state.list[e].index = e;
                                            this.setState({ord: this.state.list[e], open: true})
                                        }} ordnum={this.state.list[e].ordnum} user={this.state.list[e].user}
                                                       time={this.state.list[e].time}/>
                                    )}
                                </List>
                            </Paper>
                        </Grid>
                        <Grid item xs={12} lg={9}>
                            {this.state.open &&
                            <Paper className={this.props.classes.container}>
                                <Grid container spacing={12} alignItems="center" justify="center">
                                    <Grid item xs={12}>
                                        {renderCart(this.state.ord.cart, this.props.classes, this, true, false)}
                                    </Grid>
                                    <Grid item xs={4}>

                                        <FormControlLabel
                                            control={
                                                <Checkbox
                                                    checked={this.state.sendAgain}
                                                    onChange={(e) => this.setState({sendAgain: e.target.checked})}
                                                />
                                            }
                                            label="Reinvia"
                                        />
                                        <Button onClick={() => {
                                            if (this.state.sendAgain) {
                                                this.client.publish('order/official', JSON.stringify(
                                                    {
                                                        cart: getCarts(this.state.ord.cart, true),
                                                        orderID: this.state.ord.orderID + Date.now(),
                                                        asporto: this.state.ord.asporto,
                                                        message: " " + this.state.ord.message,
                                                        ip: this.state.ord.ip,
                                                        user: "reprint",
                                                        buono: false,
                                                        buonoID: null,
                                                        time: Math.floor(Date.now() / 1000),
                                                        ordnum: this.state.ord.ordnum,
                                                        totale: this.state.ord.totale
                                                    }));
                                                let that = this;
                                                document.getElementById("tobeprinted").postMessage({type: 'print'});
                                            }
                                        }} color="primary">
                                            Stampa
                                        </Button>
                                        <Button onClick={() => {
                                            this.setState({openModal: true, msgModal: "Sei sicuro di voler eliminare l'ordine " + this.state.ord.ordnum + " (" + this.state.ord.orderID + ") ? Questa operzione non è\nreversibile!", from: "ordine"})
                                        }} color="secondary" variant={"contained"}>
                                            Elimina
                                        </Button>
                                    </Grid>
                                    <Grid item xs={8} className={this.props.classes.scr}>
                                        <Scontrino
                                            path={scontrinoModel}
                                            elementi={getBillData(this.state.ord.cart, true)}
                                            onScontrinoLoaded={() => console.log("stampa inutile")}
                                            kw={{
                                                totale: this.state.ord.totale[0] + "." + ("0" + this.state.ord.totale[1]).substr(-2),
                                                pagato: "00.00",
                                                resto: "00.00",
                                                qrdata: JSON.stringify({
                                                    num: this.state.ord.ordnum,
                                                    time: Math.floor(Date.now() / 1000)
                                                }),
                                                buono: "RISTAMPATO",
                                                ordnum: this.state.ord.ordnum
                                            }}
                                        />
                                    </Grid>
                                </Grid>
                            </Paper>}
                        </Grid>
                    </Grid>
                </Paper>

                <Dialog
                    open={this.state.search}
                    onClose={() => this.setState({search: false})}
                    aria-labelledby="form-dialog-title"
                >
                    <DialogTitle id="form-dialog-title">Ricerca Ordine</DialogTitle>
                    {!this.state.camera && <DialogContent>

                        <DialogContentText>
                            Ricerca per numero di ordine
                        </DialogContentText>
                        <TextField
                            autoFocus
                            margin="dense"
                            id="name"
                            label="OrderNumber"
                            fullWidth
                            onChange={(e) => this.setState({num: e.target.value, id: undefined, doSearch: false})}
                        />
                        <DialogContentText>
                            Ricerca per id
                        </DialogContentText>
                        <TextField
                            autoFocus
                            margin="dense"
                            id="name"
                            label="ID"
                            fullWidth
                            onChange={(e) => this.setState({id: e.target.value, num: undefined, doSearch: false})}
                        />
                        <IconButton onClick={() => this.setState({camera: true})}><QrIcon/></IconButton>
                    </DialogContent>}
                    {this.state.camera && <DialogContent>

                        <DialogContentText>
                            Scannerizza il codice sullo scontrino
                        </DialogContentText>
                        <QrReader
                            delay={500}
                            onError={(e) => this.setState({err: e})}
                            onScan={(e) => {
                                if (e) {
                                    try {
                                        let data = JSON.parse(e);
                                        if (data.num) this.setState({
                                            id: data.num,
                                            camera: false,
                                            doSearch: true,
                                            search: false,
                                            num: undefined
                                        });
                                        else this.setState({err: "Cos'é sta merda?"});
                                    } catch (e) {
                                        this.setState({err: "Impossibile capire cosa c'é scritto =("})
                                    }
                                }
                            }}
                            style={{width: "100%"}}
                        />
                    </DialogContent>}
                    <DialogActions>
                        <Button onClick={() => this.setState({doSearch: false, search: false})} color="primary">
                            Cancel
                        </Button>
                        <Button onClick={() => this.setState({doSearch: true, search: false})} color="primary">
                            CERCA!
                        </Button>
                    </DialogActions>
                </Dialog>

                <Snackbar
                    anchorOrigin={{
                        vertical: 'bottom',
                        horizontal: 'left',
                    }}
                    open={this.state.err}
                    autoHideDuration={6000}
                    onClose={() => this.setState({err: undefined})}
                    ContentProps={{
                        'aria-describedby': 'message-id',
                    }}
                    message={<span id="message-id">{this.state.err}</span>}
                    action={[
                        <IconButton
                            key="close"
                            aria-label="Close"
                            color="inherit"
                            onClick={() => this.setState({err: undefined})}
                        >
                            <CloseIcon/>
                        </IconButton>,
                    ]}
                />

                <Snackbar
                    anchorOrigin={{
                        vertical: 'bottom',
                        horizontal: 'left',
                    }}
                    open={this.state.openStorico}
                    autoHideDuration={3000}
                    onClose={() => this.setState({openStorico: false})}
                    ContentProps={{
                        'aria-describedby': 'message-id',
                    }}
                    message={<span id="message-id">{this.state.snacktextStorico}</span>}
                    action={[
                        <IconButton
                            key="close"
                            aria-label="Close"
                            color="inherit"
                            onClick={() => this.setState({openStorico: false})}
                        >
                            <CloseIcon/>
                        </IconButton>,
                    ]}
                />

                <Modal
                    aria-labelledby="simple-modal-title"
                    aria-describedby="simple-modal-description"
                    open={this.state.openModal}
                    onClose={() => this.setState({openModal: false})}
                >
                    <div className={this.props.classes.paperr}>
                        <h4>
                            {this.state.msgModal}
                        </h4>
                        <div className={this.props.classes.rightItems}>
                            <Button onClick={() => this.setState({openModal: false})}>No</Button>
                            <Button onClick={() => {
                                this.setState({openModal: false});
                                if (this.state.from === "database") {
                                    POST(apiCalls.truncate, {
                                        user: window.ctx.get("username"),
                                        token: window.ctx.get("token")
                                    }).then(res => {
                                        if (res.state) {
                                            this.setState({snacktextStorico: res.state, openStorico: true});
                                        }
                                    })
                                } else if (this.state.from === "ordine") {
                                    POST(apiCalls.ordDel, {
                                        user: window.ctx.get("username"),
                                        token: window.ctx.get("token"),
                                        ordid: this.state.ord.orderID
                                    }).then(() => {
                                        delete this.state.list[this.state.ord.index];
                                        this.forceUpdate();
                                    })
                                }

                            }} style={{backgroundColor: 'red'}}>Si</Button>
                        </div>
                    </div>
                </Modal>

            </div>);
    }
}

let classe = withStyles(styles)(Storico);
export {classe}
export default withStyles(styles)(Storico)