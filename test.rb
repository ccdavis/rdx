
require './models.rb'

issues = Issue.all
puts "There are #{issues.size} issues in Redmine."

issues.each do |issue|
  # puts issue.keys
  unless issue.respond_to?(:subject)
    # puts issue.inspect
    puts issue.attributes

  else

    puts "#{issue.id}\t#{issue.status['name']}\t#{issue.subject}"
   end
end
