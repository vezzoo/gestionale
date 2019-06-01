import React from 'react'
import {withStyles} from '@material-ui/core/styles';
import NavBar from "./components/NavBar";
import {apiCalls} from "./consts";
import {POST, POSTSync, GET, GETSync} from "./network";
import * as cfg from "./configs/network.config"


const styles = theme => ({

});

class Template extends React.Component {

    state = {

    };


    componentDidMount() {
        POST(apiCalls.logout_all, {user: window.ctx.get("username"), token: window.ctx.get("token")}).then(e => this.props.history.push("/"));
    }

    render() {
        return (
            <div>
                <NavBar titleText='DOOOOOONE' history={this.props.history} showHome={true}/>

            </div>)
            ;
    }
}

let classe = withStyles(styles)(Template);
export {classe}
export default withStyles(styles)(Template)