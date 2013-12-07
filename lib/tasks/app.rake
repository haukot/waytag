#encoding: utf-8
namespace :app do
  desc 'Import'
  task :import => [:environment] do
    OldImport.perform
  end

  desc 'Train as bad'
  task :bad => [:environment] do
    file = File.expand_path("../../../db/tweets/bad", __FILE__)
    c = 0
    File.read(file).each_line do |line|
      Classifier.train(line, :bad)
      print " " + ((c / 10145.0) * 100).to_i.to_s + "% " if (c % 100 == 0) && c != 0
      print '.'
      c += 1
    end
  end



end
