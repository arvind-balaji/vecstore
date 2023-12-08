#include <Rcpp.h>
#include <hnswlib.h>

using namespace Rcpp;

hnswlib::HierarchicalNSW<float>* create_index_hnsw_cpp(int dim, int max_size) {
  int M = 16;
  int ef_construction = 200;

  hnswlib::L2Space* space = new hnswlib::L2Space(dim);
  hnswlib::HierarchicalNSW<float>* alg_hnsw = new hnswlib::HierarchicalNSW<float>(space, max_size, M, ef_construction);

  return alg_hnsw;
}

void add_item_hnsw_cpp(hnswlib::HierarchicalNSW<float>* index, NumericVector data, int label) {
  float* data_copy = new float[4];

  for (int i=0; i<4; i++) {
    data_copy[i] = (float) data[i];
  }

  index->addPoint(data_copy, label);
}

IntegerVector find_hnsw_cpp(hnswlib::HierarchicalNSW<float>* index, NumericVector q, int k) {
  float* data = new float[4];

  for (int i=0; i<4; i++) {
    data[i] = (float) q[i];
  }

  std::priority_queue<std::pair<float, hnswlib::labeltype>> result = index->searchKnn(data, k);

  IntegerVector indices(k);

  for (int i = 0; i < k && !result.empty(); ++i) {
    indices[i] = result.top().second;
    result.pop();
  }

  std::reverse(indices.begin(), indices.end());
  return indices;
}

//' Create an index for hierarchical navigable small worlds (HNSW) search
//'
//' This function initializes an empty index for HNSW search with a specified dimension.
//'
//' @param dim The dimension of the feature space.
//' @return A list containing an initialized index with an empty data matrix.
//' @export
//'
//' @examples
//' index <- create_index_hnsw(3, 16)
// [[Rcpp::export]]
SEXP create_index_hnsw(int dim, int max_size){
  hnswlib::HierarchicalNSW<float>* index = create_index_hnsw_cpp(dim, max_size);
  Rcpp::XPtr<hnswlib::HierarchicalNSW<float>> x_ptr(index, true);
  return x_ptr;
}

//' Add a data point to the index
//'
//' This function appends a new data point to the existing kNN index.
//'
//' @param index The index to which the data will be added.
//' @param data A vector of length (\code{dim}) to be added to the index.
//' @param label The corresponding scalar label for the data point.
//' @return Returns `NULL`
//' @export
//'
//' @examples
//' index <- create_index_hnsw(3, 16)
//' add_hnsw(index, c(1, 2, 3), 1)
// [[Rcpp::export]]
void add_hnsw(SEXP ptr, NumericVector data, int label) {
  Rcpp::XPtr<hnswlib::HierarchicalNSW<float>> index_ptr(ptr);
  add_item_hnsw_cpp(index_ptr, data, label);
}

//' Search for top K nearest neighbors
//'
//' This function finds the k nearest neighbors to a query vector within the index.
//'
//' @param index The index containing the data points.
//' @param q The query vector of length (\code{dim}) for which neighbors are to be found.
//' @param k The number of nearest neighbors to find.
//' @return Indices of the k nearest neighbors.
//' @export
//'
//' @examples
//' index <- create_index_hnsw(3, 16)
//' add_hnsw(index, c(1, 2, 3), 1)
//' I <- find_hnsw(index, c(2, 3, 4), k = 1)
// [[Rcpp::export]]
IntegerVector find_hnsw(SEXP ptr, NumericVector q, int k) {
   Rcpp::XPtr<hnswlib::HierarchicalNSW<float>> index_ptr(ptr);
   return find_hnsw_cpp(index_ptr, q, k);
 }
