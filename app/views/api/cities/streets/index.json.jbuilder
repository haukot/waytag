json.count @streets.count
json.total_count @streets.total_count
json.current_page @streets.current_page
json.num_pages @streets.num_pages

json.streets @streets do |street|
  json.partial! 'street', object: street
end
