import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';

import store from './src/store';
// routes
import AppRoutes from './src/routes';

ReactDOM.render(
    <Provider store={store}>
        <AppRoutes />
    </Provider>,
    document.getElementById('app')
)