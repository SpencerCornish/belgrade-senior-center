import React from 'react';
import { BrowserRouter, Route, Switch } from 'react-router-dom';
import Home from './containers/home';
import About from './containers/about';
export default () => {
    return (
        <BrowserRouter>
            <Switch>
                <Route exact path='/' component={Home} />
                <Route path='/about' component={About} />
            </Switch>
        </BrowserRouter>
    )
}