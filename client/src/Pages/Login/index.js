import React, { Fragment } from 'react'
import { Route, Routes } from 'react-router-dom';

//page
import Login from './sub/Login';
import IndexNotFound from '../404';

const LoginIndex = () => {
  return (
    <Fragment>
        <Routes>
            <Route exact path={`/`} element = {<Login/>}/>
            <Route path="*" element={<IndexNotFound/>} />
        </Routes>
    </Fragment>
  )
}
export default LoginIndex