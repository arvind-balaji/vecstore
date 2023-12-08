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
    std::cout << data_copy[i] << std::endl;
  }

  index->addPoint(data_copy, label);
}

IntegerVector find_hnsw_cpp(hnswlib::HierarchicalNSW<float>* index, NumericVector q, int k) {
  float* data = new float[4];

  for (int i=0; i<4; i++) {
    data[i] = (float) q[i];
    std::cout << data[i] << std::endl;
  }
  std::cout << "foo" << std::endl;
  std::priority_queue<std::pair<float, hnswlib::labeltype>> result = index->searchKnn(data, k);


  IntegerVector indices(k);

  // Retrieve the top k indices from the priority queue
  for (int i = 0; i < k && !result.empty(); ++i) {
    indices[i] = result.top().second;
    result.pop();
  }

  std::reverse(indices.begin(), indices.end());
  return indices;
}

//' @export
// [[Rcpp::export]]
SEXP create_index_hnsw(int dim, int max_size){
  hnswlib::HierarchicalNSW<float>* index = create_index_hnsw_cpp(dim, max_size);
  Rcpp::XPtr<hnswlib::HierarchicalNSW<float>> x_ptr(index, true);
  return x_ptr;
}

//' @export
// [[Rcpp::export]]
void validate_index_hnsw(SEXP index){
  Rcpp::XPtr<hnswlib::HierarchicalNSW<float>> index_ptr(index);
  index_ptr->checkIntegrity();
  std::cout << index_ptr->getCurrentElementCount() << std::endl;
  std::cout << index_ptr << std::endl;
}


//' @export
// [[Rcpp::export]]
void add_item_hnsw(SEXP ptr, NumericVector data, int label) {
  std::cout << ptr << std::endl;
  // std::vector<float> item_copy(data.size());
  // std::copy(data.begin(), data.end(), item_copy.begin());
  // // Retrieve the pointer from the external pointer (XPtr)
  Rcpp::XPtr<hnswlib::HierarchicalNSW<float>> index_ptr(ptr);
  std::cout << index_ptr->getCurrentElementCount() << std::endl;

  // // Call the C++ function using the retrieved pointer
  add_item_hnsw_cpp(index_ptr, data, label);
}

//' @export
// [[Rcpp::export]]
IntegerVector find_hnsw(SEXP ptr, NumericVector q, int k) {
   std::cout << ptr << std::endl;
   // std::vector<float> item_copy(data.size());
   // std::copy(data.begin(), data.end(), item_copy.begin());
   // // Retrieve the pointer from the external pointer (XPtr)
   Rcpp::XPtr<hnswlib::HierarchicalNSW<float>> index_ptr(ptr);

   // // Call the C++ function using the retrieved pointer
   return find_hnsw_cpp(index_ptr, q, k);
 }
