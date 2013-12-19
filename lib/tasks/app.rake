#encoding: utf-8
namespace :app do
  desc 'Import'
  task :import => [:environment] do
    OldImport.perform
  end

  desc 'Users'
  task :import_users => [:environment] do
    OldImport.perform
  end

  desc 'Train classifier'
  task :train => [:environment] do
    file = File.expand_path("../../../db/tweets/bad", __FILE__)
    c = 0
    File.read(file).each_line do |line|
      Classifier.train(line, :bad)
      print " " + ((c / 11670.0) * 100).to_i.to_s + "% " if (c % 100 == 0) && c != 0
      print '.'
      c += 1
    end

    file = File.expand_path("../../../db/tweets/good", __FILE__)
    c = 0
    File.read(file).each_line do |line|
      Classifier.train(line, :bad)
      print " " + ((c / 10585.0) * 100).to_i.to_s + "% " if (c % 100 == 0) && c != 0
      print '.'
      c += 1
    end
  end

  desc 'Train streets'
  task :streets => [:environment] do
    buffer = ""

    City::Street.find_each do |city|
      buffer += " #{city.name}"
      if buffer.length > 3000
        10.times do
          print '.'
          Classifier.train(buffer, :good)
        end
        buffer = ""
      end
    end
  end

end
