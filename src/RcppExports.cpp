// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <RcppArmadillo.h>
#include <Rcpp.h>

using namespace Rcpp;

#ifdef RCPP_USE_GLOBAL_ROSTREAM
Rcpp::Rostream<true>&  Rcpp::Rcout = Rcpp::Rcpp_cout_get();
Rcpp::Rostream<false>& Rcpp::Rcerr = Rcpp::Rcpp_cerr_get();
#endif

// create_index_hnsw
SEXP create_index_hnsw(int dim, int max_size);
RcppExport SEXP _vecstore_create_index_hnsw(SEXP dimSEXP, SEXP max_sizeSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< int >::type dim(dimSEXP);
    Rcpp::traits::input_parameter< int >::type max_size(max_sizeSEXP);
    rcpp_result_gen = Rcpp::wrap(create_index_hnsw(dim, max_size));
    return rcpp_result_gen;
END_RCPP
}
// validate_index_hnsw
void validate_index_hnsw(SEXP index);
RcppExport SEXP _vecstore_validate_index_hnsw(SEXP indexSEXP) {
BEGIN_RCPP
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type index(indexSEXP);
    validate_index_hnsw(index);
    return R_NilValue;
END_RCPP
}
// add_item_hnsw
void add_item_hnsw(SEXP ptr, NumericVector data, int label);
RcppExport SEXP _vecstore_add_item_hnsw(SEXP ptrSEXP, SEXP dataSEXP, SEXP labelSEXP) {
BEGIN_RCPP
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type ptr(ptrSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type data(dataSEXP);
    Rcpp::traits::input_parameter< int >::type label(labelSEXP);
    add_item_hnsw(ptr, data, label);
    return R_NilValue;
END_RCPP
}
// find_hnsw
IntegerVector find_hnsw(SEXP ptr, NumericVector q, int k);
RcppExport SEXP _vecstore_find_hnsw(SEXP ptrSEXP, SEXP qSEXP, SEXP kSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type ptr(ptrSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type q(qSEXP);
    Rcpp::traits::input_parameter< int >::type k(kSEXP);
    rcpp_result_gen = Rcpp::wrap(find_hnsw(ptr, q, k));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_vecstore_create_index_hnsw", (DL_FUNC) &_vecstore_create_index_hnsw, 2},
    {"_vecstore_validate_index_hnsw", (DL_FUNC) &_vecstore_validate_index_hnsw, 1},
    {"_vecstore_add_item_hnsw", (DL_FUNC) &_vecstore_add_item_hnsw, 3},
    {"_vecstore_find_hnsw", (DL_FUNC) &_vecstore_find_hnsw, 3},
    {NULL, NULL, 0}
};

RcppExport void R_init_vecstore(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
