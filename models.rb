require 'rubygems'
require 'active_model'
require './config.rb'

require 'httparty'
# require 'net/https'
# require 'open-uri'
# module Net
#  class HTTP
#    alias_method :original_use_ssl=, :use_ssl=
#
#    def use_ssl=(flag)
#      self.ca_file = File.join(File.dirname(__FILE__),'ca-bundle.crt')
#      self.verify_mode = OpenSSL::SSL::VERIFY_PEER
#      self.original_use_ssl = flag
#    end
#  end
# end
#

class AbstractActiveModel
  include ActiveModel::Serializers::JSON
  include HTTParty
  def attributes
    instance_values
  end

  def attributes=(hash)
    hash.each do |key, value|
      send("#{key}=", value)
    end
  end

  base_uri Settings::SERVER
  headers 'X-Redmine-API-Key' =>  Settings::API_KEY
  default_options.update(verify: false)

  def initialize(_hash)
  end
end

class TimeEntry < AbstractActiveModel
  attr_accessor :id,
                :project, # {:name , :id}
                :issue, # { :id }
                :user, # {  :name, :id }

                :comments,

                :activity,
                :hours,
                :spent_on,
                :created_on,
                :updated_on

  def self.all
    response = 	get('/time_entries.json')

    response.first.last.map do     |json|
      time_entry = TimeEntry.new(json)
      time_entry.attributes = json
      time_entry
    end
  end
  
  # Use post to add a time entry
  def self.add_to_issue(issue_id, hours_spent, comments, activity_id=35)
      response = post("/time_entries.json",
        "Project"=>"IPUMS","Hours"=>hours_spent.to_s,"Comments"=>comments,"activity_id"=>activity_id.to_s, "issue_id"=>issue_id.to_s)
      puts response.inspect
  
  end
  
end

class Issue < AbstractActiveModel
  attr_accessor :id, :parent, :estimated_hours, :assigned_to, :start_date,
                :closed_on, :project, :tracker, :status,
                :priority, :author, :category,
                :fixed_version, :subject, :description, :due_date,
                :done_ratio, :custom_fields, :created_on, :updated_on

  def self.all
    response = 	get('/issues.json?assigned_to_id=me&sort=status_id&limit=100')
    response.first.last.map do     |json|
      issue = Issue.new(json)
      issue.attributes = json
      issue
    end
  end
end
