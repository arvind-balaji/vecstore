#include <Rcpp.h>
#include <hnswlib.h>

using namespace Rcpp;

//' Create an HNSW index
//'
//' This function initializes an empty index for HNSW search with a specified dimension and max size.
//'
//' @param dim The dimension of the feature space.
//' @param max_size The maximum capacity of the index
//' @return A list containing an initialized index with an empty data matrix.
hnswlib::HierarchicalNSW<float>* create_index_hnsw_cpp(int dim, int max_size) {
  int M = 16;                 // Tightly connected with internal dimensionality of the data
  // strongly affects the memory consumption
  int ef_construction = 200;  // Controls index search speed/build speed tradeoff

  // Initing index
  hnswlib::L2Space space(dim);
  hnswlib::HierarchicalNSW<float>* alg_hnsw = new hnswlib::HierarchicalNSW<float>(&space, max_size, M, ef_construction);
  return alg_hnsw;
}

// Can't automatically wrap function as compileAttributes() can not include external headers
// https://stackoverflow.com/questions/18438291/building-packages-with-rcpp-attributes-not-handled-correctly

//' Create an HNSW index
//'
//' This function initializes an empty index for HNSW search with a specified dimension and max size.
//'
//' @param dim The dimension of the feature space.
//' @param max_size The maximum capacity of the index
//' @return A list containing an initialized index with an empty data matrix.
//' @export
// [[Rcpp::export]]
SEXP create_index_hnsw(int dim, int max_size) {
  hnswlib::HierarchicalNSW<float>* index = create_index_hnsw_cpp(dim, max_size);

  // Wrap the pointer in an R external pointer (XPtr)
  Rcpp::XPtr<hnswlib::HierarchicalNSW<float>> xptr(index, true);
  return xptr;
}

