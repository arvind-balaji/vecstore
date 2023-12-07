#include <string>
#include <vector>

class Student {
public:
  // Constructor
  Student(std::string name, int age, bool male) :
  name(name),
  age(age),
  male(male),
  favoriteNumbers({2, 3, 5, 7, 11}) {}

  // Getters
  std::string GetName() { return name; }
  int GetAge() { return age; }
  bool IsMale() { return male; }
  std::vector<int> GetFavoriteNumbers() { return favoriteNumbers; }

  // Methods
  bool LikesBlue() {
    return (male || age >= 10);
  }

private:
  // Member variables
  std::string name;
  int age;
  bool male;
  std::vector<int> favoriteNumbers;
};
