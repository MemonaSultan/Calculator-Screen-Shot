class City {
  bool isSelected;
  final String city;
  final String country;
  final bool isDefault;

  City({required this.isSelected, required this.city, required this.country, required this.isDefault});

  // List of Cities data
  static List<City> citiesList = [
    City(isSelected: false, city: 'London', country: 'United Kingdom', isDefault: true),
    City(isSelected: false, city: 'Tokyo', country: 'Japan', isDefault: false),
    City(isSelected: false, city: 'Delhi', country: 'India', isDefault: false),
    City(isSelected: false, city: 'Beijing', country: 'China', isDefault: false),
    City(isSelected: false, city: 'Paris', country: 'France', isDefault: false),
    City(isSelected: false, city: 'Rome', country: 'Italy', isDefault: false),
    City(isSelected: false, city: 'Lagos', country: 'Nigeria', isDefault: false),
    City(isSelected: false, city: 'Amsterdam', country: 'Netherlands', isDefault: false),
    City(isSelected: false, city: 'Barcelona', country: 'Spain', isDefault: false),
    City(isSelected: false, city: 'Miami', country: 'United States', isDefault: false),
    City(isSelected: false, city: 'Vienna', country: 'Austria', isDefault: false),
    City(isSelected: false, city: 'Berlin', country: 'Germany', isDefault: false),
    City(isSelected: false, city: 'Toronto', country: 'Canada', isDefault: false),
    City(isSelected: false, city: 'Brussels', country: 'Belgium', isDefault: false),
    City(isSelected: false, city: 'Nairobi', country: 'Kenya', isDefault: false),
  ];

  // Get the selected cities
  static List<City> getSelectedCities() {
    List<City> selectedCities = City.citiesList;
    return selectedCities.where((city) => city.isSelected == true).toList();
  }

  // Search function for city or country
  static List<City> searchCities(String query) {
    List<City> results = citiesList.where((city) {
      // Convert both city and country to lowercase and check if the query matches
      return city.city.toLowerCase().contains(query.toLowerCase()) ||
          city.country.toLowerCase().contains(query.toLowerCase());
    }).toList();
    return results;
  }
}
