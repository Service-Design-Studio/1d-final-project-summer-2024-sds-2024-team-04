import React, { Fragment } from 'react'
import { Route, Routes } from 'react-router-dom';

//page
import AuditedCaseReview from './sub/AuditedCaseReview';
import IndexNotFound from '../404';

const AuditedCaseReviewIndex = () => {
  return (
    <Fragment>
        <Routes>
            <Route exact path={`/:id`} element = {<AuditedCaseReview/>}/>
            <Route path="*" element={<IndexNotFound/>} />
        </Routes>
    </Fragment>
  )
}
export default AuditedCaseReviewIndex