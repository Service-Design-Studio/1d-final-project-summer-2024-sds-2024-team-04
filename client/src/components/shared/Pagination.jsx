import React from 'react';
import ReactPaginate from 'react-paginate';

function Pagination({ pageCount, onPageChange }) {
  return(
    <ReactPaginate
      pageCount={pageCount}
      onPageChange={onPageChange}
      containerClassName={'pagination'}
      activeClassName={'active'}
      pageLinkClassName={'btn btn-primary ms-1'}
      previousLinkClassName={'btn btn-secondary'}
      nextLinkClassName={'btn btn-secondary ms-1'}
    />
  );
}

export default Pagination;
