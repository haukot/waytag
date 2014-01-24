json.count @reports.count
json.total_count @reports.total_count
json.current_page @reports.current_page
#json.num_pages @reports.pages

json.reports @reports do |report|
  json.partial! 'report', object: report
end
