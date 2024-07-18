import React, { Fragment } from 'react'
import { Route, Routes } from 'react-router-dom';

//page
import AuditList from './sub/AuditList';
import IndexNotFound from '../404';

const AuditListIndex = () => {
  return (
    <Fragment>
        <Routes>
            <Route exact path={`/`} element = {<AuditList/>}/>
            <Route path="*" element={<IndexNotFound/>} />
        </Routes>
    </Fragment>
  )
}
export default AuditListIndex