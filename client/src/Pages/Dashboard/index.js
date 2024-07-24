import React, { Fragment } from 'react'
import { Route, Routes } from 'react-router-dom';

//page
import Dashboard from './sub/Dashboard';
import IndexNotFound from '../404';

const DashboardIndex = () => {
  return (
    <Fragment>
        <Routes>
            <Route exact path={`/`} element = {<Dashboard/>}/>
            <Route path="*" element={<IndexNotFound/>} />
        </Routes>
    </Fragment>
  )
}
export default DashboardIndex