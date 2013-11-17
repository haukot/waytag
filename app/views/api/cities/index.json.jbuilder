json.count @cities.count
json.total_count @cities.total_count
json.current_page @cities.current_page
json.num_pages @cities.num_pages

json.cities @cities do |city|
  json.partial! 'city', object: city
end
